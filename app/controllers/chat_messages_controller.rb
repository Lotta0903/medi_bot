class ChatMessagesController < ApplicationController
  SYSTEM_PROMT = "You are a helpful medical assistant specializing in medicine and geriatric care.\n
   I am a eldery patient who seeking help about my medication.
   Help me understand my medication in simple, non-technical language.\n Answer in simple plain text.\n"

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @medication = @chat.medication
    @message = ChatMessage.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      chat_history
      @ruby_llm_chat.with_instructions(instructions)
      response = @ruby_llm_chat.ask(@message.content)
      ChatMessage.create(role: "assistant", content: response.content, chat: @chat)
      @chat.generate_title_from_first_message
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: 422
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
