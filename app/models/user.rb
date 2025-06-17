class User < ApplicationRecord
  has_secure_password
  before_create :generate_confirmation_token
  scope :online, -> { where("last_seen_at > ?", 10.seconds.ago) }

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def confirm!
    update!(confirmed_at: Time.current, confirmation_token: nil)
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_password_reset_token!
    update!(
      reset_password_token: SecureRandom.urlsafe_base64,
      reset_password_sent_at: Time.current
    )
  end

  def clear_password_reset_token!
    update!(
      reset_password_token: nil,
      reset_password_sent_at: nil
    )
  end

  def password_reset_token_valid?
    reset_password_sent_at > 2.hours.ago
  end

  private

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
end
