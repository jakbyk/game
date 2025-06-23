class Play < ApplicationRecord
  has_one :chat, dependent: :destroy
  has_many :play_users, dependent: :destroy
  has_many :users, through: :play_users

  belongs_to :archived_by, class_name: "User", optional: true

  after_create :create_chat

  scope :archived, -> { where.not(archived_at: nil) }
  scope :unarchived, -> { where(archived_at: nil) }
  default_scope -> { unarchived }

  def archive(user)
    return unless user.is_admin? || play_users.find_by(user: user).is_leader
    update(archived_at: Time.now, archived_by: user)
  end

  private

  def create_chat
    chat = Chat.new(play: self)
    chat.save!
  end
end
