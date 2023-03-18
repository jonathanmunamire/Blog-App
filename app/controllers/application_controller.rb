class ApplicationController < ActionController::Base
  layout 'standard'

  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def verified_request?
    super || request_from_localhost?
  end

  def request_from_localhost?
    request.remote_ip == '127.0.0.1' || request.remote_ip == '::1'
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :bio, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :bio, :email, :password, :current_password)
    end
  end
end
