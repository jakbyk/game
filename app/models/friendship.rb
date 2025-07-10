class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender, uniqueness: { scope: :receiver }
  validates :receiver, uniqueness: { scope: :sender }
  validate :not_duplicate_in_reverse_direction
  validates :status, inclusion: { in: %w[created declined_by_sender declined_by_receiver active] }

  def self.send_friend_request(sender, receiver)
    friendship = Friendship.find_by(sender: sender, receiver: receiver)

    if friendship
      if friendship.status == "declined_by_sender"
        friendship.update(status: "created")
        friendship
      end
    else
      reverse = Friendship.find_by(sender: receiver, receiver: sender)

      if reverse
        if reverse.status == "declined_by_receiver"
          reverse.destroy!
        end
      end

      Friendship.create(sender: sender, receiver: receiver, status: "created")
    end
  end

  def self.accept_friend_request(sender, receiver)
    friendship = Friendship.find_by(sender: receiver, receiver: sender)

    return unless friendship
    return if friendship.status == "declined_by_receiver"

    friendship.update(status: "active")
    friendship
  end

  def self.decline_friend_request(sender, receiver)
    friendship = Friendship.find_by(sender: sender, receiver: receiver)

    if friendship
      friendship.update(status: "declined_by_sender")
    else
      friendship = Friendship.find_by(sender: receiver, receiver: sender)
      friendship.update(status: "declined_by_receiver") if friendship
    end
    friendship
  end

  def other_user(user)
    if sender == user
      return receiver
    end
    if receiver == user
      return sender
    end
    nil
  end

  private

  def not_duplicate_in_reverse_direction
    if Friendship.exists?(sender_id: receiver_id, receiver_id: sender_id)
      errors.add(:base, "Friendship already exists in the opposite direction")
    end
  end
end
