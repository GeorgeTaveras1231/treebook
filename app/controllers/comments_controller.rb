class CommentsController < ApplicationController
  #expose(:user){ current_user }
  expose(:comment){ comment_strategy }
  expose(:statuses){ Comment.statuses }
  expose(:new_status){ current_user.comments.new }

  def create
    if comment.save
      redirect_to :back
    else
      redirect_to :back, alert: "#{params} #{comment.errors.messages}"
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