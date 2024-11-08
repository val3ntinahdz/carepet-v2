class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :phone_number])
  end

  def after_sign_in_path_for(resource)
    # Define the path you want to redirect to. For example:
    dashboard_path # or any other path
  end
end
