class CommentsController < ApplicationController
  expose(:comment){ comment_strategy }
  expose(:statuses){ Comment.most_recent(7).statuses }
  
  expose(:new_status){ current_user.comments.new }

  layout "feed"

  def create
    respond_to do |format|
      if comment.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, alert: "#{comment.errors.full_messages.join('. ')}" }
      end
      format.js
    end
  end

  def index
    
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    end

    def comment_strategy
      if params[:comment]
        current_user.comments.new(comment_params)
      else
         current_user.comments.new
      end
    end

end