class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  add_flash_types :warning
  helper_method :current_user, :logged_in?
  before_action :track_presence, if: -> { logged_in? }

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to login_path, alert: "Musisz być zalogowany, aby zobaczyć tą stronę." unless logged_in?
  end

  def track_presence
    PresenceTracker.update(current_user)
  end

  def authenticate_admin!
    return if logged_in? && current_user.is_admin

    redirect_to root_path, alert: "Musisz być administratorem, aby zobaczyć tą stronę."
  end
end
