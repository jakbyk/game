class PagesController < ApplicationController
  def home
    @content = Setting.first ? Setting.first.main_page : ""
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
    if flash[:cm]
      @contact = ContactMessage.new(flash[:cm])
      @contact.valid?
    else
      email_to_respond = current_user ? current_user.email : nil
      @contact = ContactMessage.new(email_to_respond: email_to_respond)
    end

    render "pages/content_page"
  end

  def ranking
    @plays = Play.rank
    @almost_done = Play.next_rank
    @old_rank = Play.old_rank
  end

  def tournament
    flash_data = flash[:data]
    flash_data = flash_data.transform_keys(&:to_sym) if flash_data.is_a?(Hash)
    @current_user = current_user
    @data = { first_name: nil, last_name: nil, email: nil, phone: nil, over_18: false, parent_first_name: nil, parent_last_name: nil, school_address: nil, school_name: nil, parent_email: nil, parent_phone_number: nil, additional_info: nil }
    if flash_data
      @data[:first_name] = flash_data[:first_name] if flash_data[:first_name]
      @data[:last_name] = flash_data[:last_name] if flash_data[:last_name]
      @data[:email] = flash_data[:email] if flash_data[:email]
      @data[:phone] = flash_data[:phone] if flash_data[:phone]
      @data[:over_18] = true if flash_data[:over_18]
      @data[:parent_first_name] = flash_data[:parent_first_name] if flash_data[:parent_first_name]
      @data[:parent_last_name] = flash_data[:parent_last_name] if flash_data[:parent_last_name]
      @data[:school_address] = flash_data[:school_address] if flash_data[:school_address]
      @data[:school_name] = flash_data[:school_name] if flash_data[:school_name]
      @data[:parent_email] = flash_data[:parent_email] if flash_data[:parent_email]
      @data[:parent_phone_number] = flash_data[:parent_phone_number] if flash_data[:parent_phone_number]
      @data[:additional_info] = flash_data[:additional_info] if flash_data[:additional_info]
    end

    if @current_user
      @data[:email] = @current_user.email if @data[:email] == nil
      @data[:first_name] = @current_user.first_name if @data[:first_name] == nil
      @data[:last_name] = @current_user.last_name if @data[:last_name] == nil
    end
  end
end
