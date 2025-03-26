class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_participation, only: [:update, :destroy]

  def create
    @event = Event.find(params[:event_id])
    @participations = @event.participations
    participation = Participation.new(user: current_user, event_id: params[:event_id], status: "pending")
    if @participations.where(status:"accepted").count < participation.event.max_participants
      participation.save
      redirect_to event_path(params[:event_id]), notice: "Demande envoyée!"
    else
      redirect_to event_path(params[:event_id]), alert: "Erreur lors de l'inscription! Evènement complet."
    end
  end

  def update
    participation = Participation.find(params[:id])
    if params[:status].present? && Participation.statuses.keys.include?(params[:status])
      participation.update(status: params[:status])
      redirect_to event_path(participation.event), notice: "Statut mis à jour!"
    else
      redirect_to event_path(participation.event), alert: "Statut invalide!"
    end
  end

  def accepted
    @participation = Participation.find(params[:id])
    @participation.update(status: "accepted")
    redirect_to event_path(@participation.event), notice: "Demande validée!"
  end

  def rejected
    @participation = Participation.find(params[:id])
    @participation.update(status: "rejected")
    redirect_to event_path(@participation.event), notice: "Demande refusée!"
  end


  def destroy
    if current_user == @participation.user
      @participation.destroy
      redirect_to user_participations_path, notice: "Participation annulée avec succès."
    else
      redirect_to user_participations_path, alert: "Vous ne pouvez pas annuler cette participation."
    end
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end
end
