class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom
  before_action :authorize_participant

  def show
    if @chatroom.nil?
      redirect_to events_path, alert: "La discussion n'existe pas pour cet événement."
    else
      @messages = @chatroom.messages
      @message = Message.new
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find_by(event_id: params[:event_id])
  end

  def authorize_participant
    participation = current_user.participations.find_by(event_id: params[:event_id])
    unless participation&.accepted? || current_user == @chatroom.event.user
      redirect_to events_path, alert: "Vous devez être accepté à l'événement pour accéder à la discussion."
    end
  end
end
