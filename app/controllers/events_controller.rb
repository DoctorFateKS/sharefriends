class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  def index
    if current_user && current_user.profile.nil?
      redirect_to new_profile_path and return
    end

    @user_moods = current_user.profile.mood
    @user_hobbies = current_user.profile.hobbie.to_s.split(",")

    if params[:query].present?
      sql_query = "title ILIKE :query OR address ILIKE :query"
      @events = Event.where(sql_query, query: "%#{params[:query]}%")
    else
      @events = Event.all
    end
    @markers = @events.geocoded.map do |event|
      {
      lat: event.latitude,
      lng: event.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {event: event}),
      marker_html: render_to_string(partial: "marker", locals: {event: event})
    }
    end
  end


  def show
    if @event.user == current_user
    @pending_participations = @event.participations.select{|participation|participation.status == "pending"}
    @accepted_participations = @event.participations.select{|participation|participation.status == "accepted"}
    @rejected_participations = @event.participations.select{|participation|participation.status == "rejected"}
    end

    @markers =[{
      lat: @event.latitude,
      lng: @event.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {event: @event}),
      marker_html: render_to_string(partial: "marker", locals: {event: @event})
    }]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.activity = params[:activity]
    @event.user = current_user
    @event.mood = current_user.mood
    if @event.save!
      @chatroom = Chatroom.create(event: @event)
      @participation = Participation.new(user: current_user, event_id: @event.id, status: "accepted")
      @participation.save!
      redirect_to @event, notice: "Événement créé!"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Événement mis à jour!"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @event.user
      @event.destroy
      redirect_to dashboard_path, notice: "Événement supprimé !"
    else
      redirect_to dashboard_path, alert: "Vous ne pouvez pas supprimer cet événement."
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :address, :mood, :activity, :max_participants, :status, :latitude, :longitude, :photo)
  end
end
