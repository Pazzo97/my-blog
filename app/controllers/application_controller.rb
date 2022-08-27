class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name bio password password_confirmation])
  end
end
