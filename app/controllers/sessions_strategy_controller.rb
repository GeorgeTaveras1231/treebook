class SessionsStrategyController < Devise::SessionsController
  skip_before_action :assert_session
end