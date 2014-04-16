class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :signed_in?

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protected
    def signed_in?
      unless current_user
        redirect_to root_path, alert: "You are not signed in."
      end
    end
end
