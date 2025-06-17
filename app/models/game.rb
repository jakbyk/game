class Game < ApplicationRecord
  has_one :chat, dependent: :destroy
  has_many :game_users
  has_many :users, through: :game_users
end
