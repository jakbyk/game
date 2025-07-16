class PagesController < ApplicationController
  before_action :require_login, only: [ :inbox ]

  def home
    @chat = current_user&.is_admin ? Chat.find_or_create_by!(play_id: nil) : nil
  end

  def inbox
    @chats = current_user.private_chats
  end

  def regulation
    @content = Setting.first.regulations
    @title = "Regulamin"

    render "pages/content_page"
  end

  def information_on_the_processing_of_personal_data
    @content = Setting.first.information_on_the_processing_of_personal_data
    @title = "Informacja o procesowaniu danych osobowych"

    render "pages/content_page"
  end
end
