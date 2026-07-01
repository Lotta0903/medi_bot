class ChatsController < ApplicationController
  def create
    @medication = Medication.find(params[:medication_id])

    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.medication = @medication
    @chat.user = current_user
    if @chat.save
      redirect_to chat_path(@chat)
    else
      @chats = @medication.chats.where(user: current_user)
      render "medications/show"
    end
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = ChatMessage.new
  end
end
