class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
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
      redirect_to events_path, notice: "Événement supprimé !"
    else
      redirect_to events_path, alert: "Vous ne pouvez pas supprimer cet événement."
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :address, :mood, :activity, :max_participants, :status, :latitude, :longitude)
  end
end
