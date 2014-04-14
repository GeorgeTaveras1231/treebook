class LikesController < ApplicationController
  expose(:current_like){ current_user.like(find_likeable) }

  before_action :verify_like

  def create
    respond_to do |format|
      if current_like.save
        format.html { redirect_to :back, notice: "liked :)" }
      else
        format.html { redirect_to :back, alert: "#{current_like.errors.messages.values.join('. ')}" }
      end
    end
  end

  def destroy
    current_like.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: "disliked :(" }
    end

  end

  private
    def find_likeable
      params.each do |name, val|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(val)
        end
      end
      nil
    end

    def verify_like
      #users cant like their own material
      if find_likeable.user.id == current_user.id
        redirect_to :back, alert: "You can't like your own stuff."
      end
    end

end
