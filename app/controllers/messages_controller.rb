class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [ :edit, :update, :destroy ]
  before_action :check_permission, only: [ :edit, :update, :destroy ]

  def create
    @message = @chat.messages.build(message_params.merge(user: current_user))

    if @message.save
      Turbo::StreamsChannel.broadcast_append_to(
        "chat_#{@chat.id}",
        target: "messages",
        partial: "messages/message",
        locals: { message: @message, chat: @chat }
      )
    else
      render partial: "messages/form", status: :unprocessable_entity
    end
  end

  def edit
    render turbo_stream: turbo_stream.replace(
      "message_#{@message.id}",
      partial:  "messages/form",
      locals:   { message: @message, chat: @chat }
    )
  end

  def update
    if @message.update(message_params)
      Turbo::StreamsChannel.broadcast_replace_to(
        "chat_#{@chat.id}",
        target: "message_#{@message.id}",
        partial: "messages/message",
        locals: { message: @message, chat: @chat }
      )
      head :ok
    else
      render turbo_stream: turbo_stream.replace(
        "message_#{@message.id}",
        partial:  "messages/message",
        locals:   { message: @message, chat: @chat }
      )
    end
  end

  def destroy
    @message.destroy
    Turbo::StreamsChannel.broadcast_remove_to(
      "chat_#{@chat.id}",
      target: "message_#{@message.id}"
    )

    head :ok
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def check_permission
    return if current_user&.is_admin
    return if PlayUser.find_by(play: @chat&.play, user: current_user)&.is_leader
    return if PlayUser.find_by(play: @chat&.play, user: current_user) && current_user == @message&.user

    head :forbidden
  end
end
