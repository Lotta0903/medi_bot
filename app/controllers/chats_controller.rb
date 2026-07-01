class ChatsController < ApplicationController
  def new
    @medication = Medication.find(params[:medication_id])
    @chat = @medication.chats.new
  end
end
