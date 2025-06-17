class MessagesController < ApplicationController
  before_action :set_chat

  def create
    @message = @chat.messages.build(message_params.merge(user: current_user))

    if @message.save
      Turbo::StreamsChannel.broadcast_append_to(
        "chat_#{@chat.id}",
        target: "messages",
        partial: "messages/message",
        locals: { message: @message }
      )
    else
      render partial: "messages/form", status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
