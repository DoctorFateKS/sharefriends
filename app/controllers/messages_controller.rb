class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom
  before_action :authorize_participant

  def create
    message = Message.new(message_params)
    message.user = current_user
    message.chatroom = @chatroom

    if message.save
      redirect_to event_chatroom_path(@chatroom.event)
    else
      redirect_to event_chatroom_path(@chatroom.event), alert: "Erreur d'envoi !"
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def authorize_participant
    participation = current_user.participations.find_by(event_id: @chatroom.event.id)
    unless participation&.accepted?
      redirect_to events_path, alert: "Vous devez être accepté à l'événement pour envoyer des messages."
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

