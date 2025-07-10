class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [ :show, :update, :make_friend, :accept_friend, :decline_friend ]

  def show
    @is_my_profile = @user == current_user
    @is_friend = current_user.friend_users.include? @user
    @could_be_friend = !@is_my_profile && Friendship.find_by(sender: current_user, receiver: @user, status: "declined_by_receiver").nil? && Friendship.find_by(sender: @user, receiver: current_user, status: "declined_by_sender").nil?
    @send_approve_friendship = Friendship.find_by(sender: current_user, receiver: @user, status: "created")
    @you_dont_wish_to_be_friendship = Friendship.find_by(sender: current_user, receiver: @user, status: "declined_by_sender") || Friendship.find_by(sender: @user, receiver: current_user, status: "declined_by_receiver")
    @he_dont_wish_to_be_friendship = Friendship.find_by(sender: @user, receiver: current_user, status: "declined_by_sender") || Friendship.find_by(sender: current_user, receiver: @user, status: "declined_by_receiver")
    @awaiting_approve_friendship = Friendship.find_by(sender: @user, receiver: current_user, status: "created")
    @friendship_to_approve = @is_my_profile ? current_user.pending_friend_requests : nil
    @friendship_declined_by_me = @is_my_profile ? current_user.declined_by_me : nil
    @friends = @user.friend_users
  end

  def update
    return redirect_to profile_path(id: @user.id), alert: "Nie możesz aktualizować innych profili." unless @user == current_user || current_user.is_admin?
    if @user.update(user_params)
      redirect_to profile_path(id: @user.id), notice: "Avatar zaktualizowany."
    else
      redirect_to profile_path(id: @user.id), alert: "Avatar nie został zaktualizowany."
    end
  end

  def make_friend
    return redirect_to profile_path(id: @user.id), alert: "Nie możesz zaprosić samego siebie." if @user == current_user
    friendship = Friendship.send_friend_request(current_user, @user)
    if friendship && friendship.status == "created"
      redirect_to profile_path(id: @user.id), notice: "Zaproszenie zostało wysłane."
    else
      redirect_to profile_path(id: @user.id), alert: "Nie można wysłać zaproszenia."
    end
  end

  def accept_friend
    return redirect_to profile_path(id: @user.id), alert: "Nie możesz zaprosić samego siebie." if @user == current_user
    friendship = Friendship.accept_friend_request(current_user, @user)
    if friendship && friendship.status == "active"
      redirect_to profile_path(id: @user.id), notice: "Zaproszenie zostało zaakceptowane."
    else
      redirect_to profile_path(id: @user.id), alert: "Nie można zaakceptiować zaproszenia."
    end
  end

  def decline_friend
    return redirect_to profile_path(id: @user.id), alert: "Nie możesz usunąc ze znajomych samego siebie." if @user == current_user
    friendship = Friendship.decline_friend_request(current_user, @user)
    if friendship && friendship.status != "active"
      redirect_to profile_path(id: @user.id), notice: "Użytkownik został usunięty ze znajomych."
    else
      redirect_to profile_path(id: @user.id), alert: "Nie można usunąć użytkownika ze znajomych."
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

  def set_user
    id = params[:id] || params[:profile_id]
    @user = User.find_by(id: id)
    redirect_to root_path, alert: "Nie znaleziono takiego użytkownika" unless @user
  end
end
