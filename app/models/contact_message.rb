class ContactMessage < ApplicationRecord
  belongs_to :user, optional: true
  validates :message, presence: true
  validates :email_to_respond, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :to_read, -> { where(is_read: false) }
  scope :readed, -> { where(is_read: true) }

  has_many :responses, dependent: :destroy

  def last_response
    responses.order(created_at: :desc).first
  end
end
