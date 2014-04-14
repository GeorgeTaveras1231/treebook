class StaticController < ApplicationController
  skip_before_action :signed_in?

  before_action :new_user, only: :home

  def home
  end

  def about
  end

  private
    def new_user
      if current_user
        redirect_to statuses_path
      else
        redirect_to new_user_registration_path
      end
    end
end
