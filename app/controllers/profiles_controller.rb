class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def new
    @profile = Profile.new
  end

  def show
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.hobbie = params[:profile][:hobbies].reject { |hobbie| hobbie == "0" }.join(", ")

    if @profile.save!
      redirect_to authenticated_root_path, notice: "Profil créé avec succès !"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update!(profile_params)
      redirect_to profile_path, notice: "Profil mis à jour !"
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :mood, :hobbie, :photo)
  end
end
