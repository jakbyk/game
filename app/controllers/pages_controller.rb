class PagesController < ApplicationController
  def home
    @chat = Chat.find_or_create_by!(play_id: nil)
  end
end
