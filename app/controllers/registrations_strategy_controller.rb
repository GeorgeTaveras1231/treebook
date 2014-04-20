class RegistrationsStrategyController < Devise::RegistrationsController
  skip_before_action :assert_session
  
  before_action :configure_registration_parameters
  expose :user, params: :user_params


  protected
    def configure_registration_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u| 
        u.permit(:first_name, :last_name, :email, :password, :current_password, :password_confirmation) 
      end
    end
end
