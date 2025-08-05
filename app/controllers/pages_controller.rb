class PagesController < ApplicationController
  def home
    @content = Setting.first.main_page
    @chat = (current_user&.is_admin || current_user&.is_tester) ? Chat.find_or_create_by!(play_id: nil) : nil
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

  def how_to_play
    @content = Setting.first.how_to_play
    @title = "Jak grać?"

    render "pages/content_page"
  end

  def contact
    @content = Setting.first.contact
    @title = "Kontakt"

    render "pages/content_page"
  end

  def ranking
    @plays = Play.rank
  end
end
