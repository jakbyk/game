class TournamentRegistrationController < ApplicationController
  before_action :set_data, only: [ :create ]

  def create
    flash[:data] = @data
    return redirect_to pages_tournament_path, alert: "Musisz zaakceptować zgodę na przetwarzanie danych osobowych" unless params[:accept_data_processing].to_i == 1
    unless current_user
      return redirect_to pages_tournament_path, alert: "Musisz podać imię" unless params[:first_name].present?
      return redirect_to pages_tournament_path, alert: "Musisz podać nazwisko" unless params[:last_name].present?
      return redirect_to pages_tournament_path, alert: "Musisz podać email" unless params[:last_name].present?
      return redirect_to pages_tournament_path, alert: "Musisz podać nazwę użytkownika" unless params[:name].present?
    end
    unless params[:over_18]
      return redirect_to pages_tournament_path, alert: "Musisz podać imię rodzica" unless params[:parent_first_name].present?
      return redirect_to pages_tournament_path, alert: "Musisz podać nazwisko rodzica" unless params[:parent_last_name].present?
      return redirect_to pages_tournament_path, alert: "Musisz podać email rodzica" unless params[:parent_email].present?
      return redirect_to pages_tournament_path, alert: "Musisz podać numer telefonu rodzica" unless params[:parent_phone_number].present?
    end
    return redirect_to pages_tournament_path, alert: "Musisz podać numer telefonu" unless params[:phone].present?
    return redirect_to pages_tournament_path, alert: "Musisz podać nazwę szkoły" unless params[:school_name].present?
    return redirect_to pages_tournament_path, alert: "Musisz podać adres szkoły" unless params[:school_address].present?
    if params[:password].present? || params[:password_confirmation].present?
      return redirect_to pages_tournament_path, alert: "Podano dwa różne hasła" unless params[:password] == params[:password_confirmation]
    end
    @user = find_or_create_user
    return redirect_to pages_tournament_path, alert: "Nie udało się znaleźć/stworzyć użytkownika" unless @user
    @data[:status] = @data[:over_18] ? "await_approve" : "await_parent"
    td = TournamentData.new(@data)
    td.user = @user
    if td.save
      flash[:data] = nil
      if current_user
        if @data[:over_18]
          redirect_to pages_tournament_path, notice: "Zgłoszenie zostało wysłane."
        else
          UserMailer.parent_confirmation_email(@user).deliver_later
          redirect_to pages_tournament_path, notice: "Zgłoszenie zostało wysłane. Powiadom rodzica, by sprawdził skrzynkę mailową."
        end
      else
        if @data[:over_18]
          redirect_to pages_tournament_path, notice: "Zgłoszenie zostało wysłane. Sprawdź swoją skrzynkę mailową."
        else
          UserMailer.parent_confirmation_email(@user).deliver_later
          redirect_to pages_tournament_path, notice: "Zgłoszenie zostało wysłane. Sprawdź swoją skrzynkę mailową i powiadom rodzica, by zrobił to samo."
        end
      end
    else
      redirect_to pages_tournament_path, alert: "Nie udało się zgłosić do turnieju"
    end
  end

  def approve
    td = TournamentData.find_by(id: params[:id])
    return redirect_to root_path, alert: "Nie udało się potwierdzić danych" unless td && (td.status == "await_parent" || td.status == "await_approve")
    if td.update(status: "await_approve")
      redirect_to root_path, notice: "Dziękujemy za potwierdzenie danych"
    else
      redirect_to root_path, alert: "Nie udało się potwierdzić danych"
    end
  end

  private

  def set_data
    @data = { first_name: nil, last_name: nil, email: nil, phone: nil, over_18: false, parent_first_name: nil, parent_last_name: nil, school_address: nil, school_name: nil, parent_email: nil, parent_phone_number: nil, additional_info: nil }
    @data[:first_name] = params[:first_name] if params[:first_name]
    @data[:last_name] = params[:last_name] if params[:last_name]
    @data[:email] = params[:email] if params[:email]
    @data[:phone] = params[:phone] if params[:phone]
    @data[:over_18] = true if params[:over_18]
    @data[:parent_first_name] = params[:parent_first_name] if params[:parent_first_name]
    @data[:parent_last_name] = params[:parent_last_name] if params[:parent_last_name]
    @data[:school_address] = params[:school_address] if params[:school_address]
    @data[:school_name] = params[:school_name] if params[:school_name]
    @data[:parent_email] = params[:parent_email] if params[:parent_email]
    @data[:parent_phone_number] = params[:parent_phone_number] if params[:parent_phone_number]
    @data[:additional_info] = params[:additional_info] if params[:additional_info]
  end

  def find_or_create_user
    return current_user if current_user

    u = User.find_by(email: params[:email])
    unless u
      u = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], first_name: params[:first_name], last_name: params[:last_name], name: params[:name])
      if params[:accept_data_processing]
        u.time_of_acceptance_of_information_on_the_processing_of_personal = Time.current
      end
      if params[:accept_regulations]
        u.time_of_acceptance_of_the_regulations = Time.current
      end
      if u.save
        UserMailer.confirmation_email(u).deliver_later
        u
      else
        nil
      end
    end
  end
end
