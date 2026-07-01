class Chat < ApplicationRecord
  belongs_to :medication
  belongs_to :user
  has_many :chat_mmessages, dependent: :destroy
end
