class SessionsStrategyController < Devise::SessionsController
  skip_before_action :signed_in?
end