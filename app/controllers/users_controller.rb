class UsersController < ApplicationController
	expose :users
	expose :user
  expose(:all_statuses){ user.statuses.most_recent}
  expose(:current_status) { user.statuses.new }
end
