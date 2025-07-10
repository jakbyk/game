class PagesController < ApplicationController
  before_action :require_login, only: [ :inbox ]

  def home
    @chat = current_user&.is_admin ? Chat.find_or_create_by!(play_id: nil) : nil
  end

  def inbox
    @chats = current_user.private_chats
  end
end
