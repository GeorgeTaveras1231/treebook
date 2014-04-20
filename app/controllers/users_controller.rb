class UsersController < ApplicationController
	expose :users
	expose :user
  expose(:all_statuses){ user.comments.most_recent.statuses}
  expose(:current_status) { user.comments.new }
end
