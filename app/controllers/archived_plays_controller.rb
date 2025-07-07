class ArchivedPlaysController < ApplicationController
  def index
    @plays = current_user.plays.done
  end

  def show
    @play = current_user.plays.done.find(params[:id])
  end
end
