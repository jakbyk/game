class User < ApplicationRecord
  has_secure_password
  before_create :generate_confirmation_token
  scope :online, -> { where("last_seen_at > ?", 12.seconds.ago) }

  has_many :play_users, dependent: :destroy
  has_many :plays, through: :play_users
  has_many :sent_friendships, class_name: "Friendship", foreign_key: :sender_id, dependent: :destroy
  has_many :received_friendships, class_name: "Friendship", foreign_key: :receiver_id, dependent: :destroy
  has_many :sent_friends, through: :sent_friendships, source: :receiver
  has_many :received_friends, through: :received_friendships, source: :sender
  has_many :play_invitations, dependent: :destroy

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

  def allowed_to_invite_to_game?(play)
    PlayUser.find_by(user: self, play: play)&.is_leader
  end

  def friend_users
    sent = sent_friendships.where(status: "active").includes(:receiver).map(&:receiver)
    received = received_friendships.where(status: "active").includes(:sender).map(&:sender)
    sent + received
  end

  def pending_friend_requests
    received_friendships.where(status: "created").includes(:sender)
  end

  def declined_by_me
    sent_friendships.where(status: "declined_by_sender") +
      received_friendships.where(status: "declined_by_receiver")
  end

  def declined_by_others
    sent_friendships.where(status: "declined_by_receiver") +
      received_friendships.where(status: "declined_by_sender")
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
