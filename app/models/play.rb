class Play < ApplicationRecord
  has_one :chat, dependent: :destroy
  has_many :play_users, dependent: :destroy
  has_many :users, through: :play_users
end
