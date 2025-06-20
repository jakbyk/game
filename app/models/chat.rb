class Chat < ApplicationRecord
  belongs_to :play, optional: true
  has_many :messages, dependent: :destroy

  validate :only_one_global_chat

  def have_permission_to_mage_chat(user)
    return true if user.is_admin
    return false unless play
    pu = PlayUser.find_by(user: user, play: play)
    return false unless pu

    pu.is_leader
  end

  private

  def only_one_global_chat
    return if play_id.present?

    if Chat.where(play_id: nil).where.not(id: id).exists?
      errors.add(:base, "Only one global chat (without a play) can exist.")
    end
  end
end
