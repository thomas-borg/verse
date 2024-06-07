class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  has_many :messages
end
