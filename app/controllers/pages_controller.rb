class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
    @participations = @user.accepted_events # Événements où l'utilisateur est accepté
    @chatrooms = Chatroom.joins(:event).where(events: { user_id: @user.id }) # Chatrooms des events créés
  end
end
