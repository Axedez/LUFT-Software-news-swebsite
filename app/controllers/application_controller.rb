class ApplicationController < ActionController::Base
  layout :choose_layout
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def choose_layout
    current_user ? 'account' : 'application'
  end
end
