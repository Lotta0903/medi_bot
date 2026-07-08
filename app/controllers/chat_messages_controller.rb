class ChatMessagesController < ApplicationController
  SYSTEM_PROMT = "You are a helpful medical assistant specializing in medicine and geriatric care.\n
   I am a eldery patient who seeking help about my medication.\n
   Help me understand my medication in simple, non-technical language.\n Answer in simple plain text.\n"

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @medication = @chat.medication
    @message = ChatMessage.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      @ruby_llm_chat.with_instructions(instructions)
      chat_history

      response = @ruby_llm_chat.ask(@message.content)
      @assistant_message = ChatMessage.create(role: "assistant", content: response.content, chat: @chat)
      @chat.generate_title_from_first_message

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            :new_message,
            partial: "chat_messages/form",
            locals: { chat: @chat, message: @message }
          )
        end
        format.html { render "chats/show", status: 422 }
      end
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:content)
  end

  def medication_name
    "Here is the name of the medication: #{@medication.name}."
  end

  def instructions
    [SYSTEM_PROMT, medication_name].compact.join("\n\n")
  end

  def chat_history
    @chat.chat_messages.each do |message|
      @ruby_llm_chat.add_message(role: message.role, content: message.content)
    end
  end
end
