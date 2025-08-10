class Response < ApplicationRecord
  belongs_to :contact_message
  belongs_to :user, optional: true

  validates :message, presence: true
end
