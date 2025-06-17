class PresenceTracker
  def self.update(user)
    return if user.nil?

    if user.last_seen_at.nil? || user.last_seen_at < 2.seconds.ago
      user.update_column(:last_seen_at, Time.current)
      broadcast
    end
  end

  def self.broadcast
    Turbo::StreamsChannel.broadcast_replace_to(
      "online_users",
      target: "online_users_list",
      partial: "users/online_users"
    )
  end
end
