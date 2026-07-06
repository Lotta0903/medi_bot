class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :medications, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :chats, dependent: :destroy
end
