class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user
    @participations = @user.accepted_events # Événements où l'utilisateur est accepté
    @chatrooms = Chatroom.joins(:event).where(events: { user_id: @user.id }) # Chatrooms des events créés
  end
end

