class CommentsController < ApplicationController
  expose(:comment){ comment_strategy }
  expose(:statuses){ Comment.most_recent(7).statuses }
  expose(:new_status){ current_user.comments.new }

  before_action :load_changes

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

  def update
    respond_to do |format|
      comment.save
      format.js
      format.html { redirect_to comments_path }
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def destroy
    comment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to comments_path }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    end

    def load_changes
      comment.update(comment_params) if params[:comment]
    end

    def comment_strategy
      if params[:id]
        current_user.comments.find(params[:id])
      else
        current_user.comments.new
      end
    end

end