class PlayInvitation < ApplicationRecord
  belongs_to :play
  belongs_to :user
  belongs_to :invitor, class_name: "User"

  validates :user, uniqueness: { scope: :play }

  def accept(user, play)
    if PlayUser.find_by(user_id: user.id, play_id: play.id)
      self.destroy!
      return false
    end
    return false unless user.allowed_to_create_tournament_new_game?
    pu = PlayUser.create(play: play, user: user)
    if pu.save
      self.destroy!
      true
    end
  end
end
