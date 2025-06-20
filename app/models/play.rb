class Play < ApplicationRecord
  has_one :chat, dependent: :destroy
  has_many :play_users, dependent: :destroy
  has_many :users, through: :play_users

  after_create :create_chat

  private

  def create_chat
    chat = Chat.new(play: self)
    chat.save!
  end
end
