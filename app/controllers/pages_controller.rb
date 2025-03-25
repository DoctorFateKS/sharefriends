class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
    @chatrooms = Chatroom.joins(:event).where(events: { user_id: @user.id })
    @created_events = @user.hosted_events
    @pending_events = @user.pending_events
    @accepted_events = @user.accepted_events
    @pending_participations = @created_events.map do | event |
      event.participations.where status: "pending"
    end.flatten
    @accepted_participations = @created_events.map do | event |
      event.participations.where status: "accepted"
    end.flatten


  end
end
