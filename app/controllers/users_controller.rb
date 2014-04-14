class UsersController < ApplicationController
	expose :users
	expose :user
  expose(:current_status) { user.statuses.new }
end
