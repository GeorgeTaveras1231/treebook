class LikesController < ApplicationController
  
  expose(:current_like){ current_user.like(find_likeable) }
  expose(:current_likeable){ current_like.owner }

  before_action :verify_like

  def create
    respond_to do |format|
      if current_like.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, alert: "#{current_like.errors.messages.values.join('.<br>')}" }
      end
      format.js { render 'update_likes_bar' }
    end
  end

  def destroy
    current_like.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'update_likes_bar' }
    end

  end

  private
    def verify_like
      #users cant like their own stuff
      if find_likeable.user.id == current_user.id
        redirect_to :back, alert: "You can't like your own stuff."
      end
    end

end
