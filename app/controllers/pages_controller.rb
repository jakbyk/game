class PagesController < ApplicationController
  def home
    @chat = current_user&.is_admin ? Chat.find_or_create_by!(play_id: nil) : nil
  end
end
