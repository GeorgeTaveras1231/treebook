class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :assert_session

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protected
    include PolymorphicHelper
    include SessionHelper

    def assert_session
      unless signed_in?
        redirect_to root_path, alert: "You are not signed in."
      end
    end
end
