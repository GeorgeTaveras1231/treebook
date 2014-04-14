class RegistrationsStrategyController < Devise::RegistrationsController
  skip_before_action :signed_in?
end
