class Medication < ApplicationRecord
  belongs_to :user
  has_many :medication_logs, dependent: :destroy
  has_many :chats, dependent: :destroy
end
