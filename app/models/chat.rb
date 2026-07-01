class Chat < ApplicationRecord
  belongs_to :medication
  belongs_to :user
  has_many :chat_messages, dependent: :destroy
end
