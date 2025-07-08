class User < ApplicationRecord
  has_secure_password
  before_create :generate_confirmation_token
  scope :online, -> { where("last_seen_at > ?", 10.seconds.ago) }

  has_many :play_users, dependent: :destroy
  has_many :plays, through: :play_users
  has_one_attached :avatar

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validate :acceptable_avatar

  default_scope { order(created_at: :desc) }

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

  def allowed_to_create_new_game?
    is_admin? || plays.count < 4
  end

  def allowed_to_archive_game?(play)
    is_admin? || PlayUser.find_by(user: self, play: play)&.is_leader
  end

  def allowed_to_delete_game?(play)
    is_admin?
  end

  def allowed_to_proceed_game?(play)
    PlayUser.find_by(user: self, play: play)&.is_leader
  end

  private

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def acceptable_avatar
    return unless avatar.attached?

    unless avatar.byte_size <= 1.megabyte
      errors.add(:avatar, "jest za duży (max 1MB)")
    end

    acceptable_types = [ "image/jpeg", "image/png", "image/webp" ]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "musi być JPEG, PNG lub WEBP")
    end
  end
end
