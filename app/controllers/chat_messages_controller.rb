class ChatMessagesController < ApplicationController
  SYSTEM_PROMT = "You are a helpful medical assistant specializing in medicine and geriatric care.
   I am a eldery patient who seeking help about my medication
   Help me understand my medication in simple, non-technical language. Answer in simple plain text"

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @medication = @chat.medication

    @message = ChatMessage.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      ruby_llm_chat = RubyLLM.chat(model: 'gpt-4.1-nano')
      ruby_llm_chat.with_instructions(SYSTEM_PROMT)
      response = ruby_llm_chat.ask(@message.content)
      ChatMessage.create(role: "assistant", content: response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: 422
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:content)
  end
end
