class StaticController < ApplicationController
  skip_before_action :assert_session

  before_action :authorize_visit, only: :home
  
  def home
  end

  def about
  end

    private

      def authorize_visit
        if signed_in?
          redirect_to comments_path
        else
          redirect_to new_user_registration_path
        end
      end
end
