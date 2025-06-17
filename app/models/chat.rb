class Chat < ApplicationRecord
  belongs_to :play, optional: true
  has_many :messages, dependent: :destroy

  validate :only_one_global_chat

  private

  def only_one_global_chat
    return if play_id.present?

    if Chat.where(play_id: nil).where.not(id: id).exists?
      errors.add(:base, "Only one global chat (without a play) can exist.")
    end
  end
end
