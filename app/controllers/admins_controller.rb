class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def users
    @users = User.all
  end

  def games
    @plays = Play.all
  end

  def archived_games
    @plays = Play.done
  end
end
