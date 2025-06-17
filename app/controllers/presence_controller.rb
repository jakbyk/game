class PresenceController < ApplicationController
  before_action :require_login

  def ping
    PresenceTracker.update(current_user)
    head :ok
  end
end
