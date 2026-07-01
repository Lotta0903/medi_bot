class ChatMessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])
    @medication = @chat.medication

    @message = ChatMessage.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.save
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
