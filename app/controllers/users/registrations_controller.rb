class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    authenticated_root_path # Redirige vers la liste des événements après inscription
  end

  def after_sign_in_path_for(resource)
    authenticated_root_path # Redirige après connexion
  end
end
