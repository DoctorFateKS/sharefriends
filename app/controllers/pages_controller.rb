class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
    @participations = @user.accepted_events
    @chatrooms = Chatroom.joins(:event).where(events: { user_id: @user.id })
    @created_events = @user.hosted_events
    @pending_events = @user.pending_events
    @accepted_events = @user.accepted_events
  end
end
