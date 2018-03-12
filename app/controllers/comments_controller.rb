class CommentsController < ApplicationController
  before_action :set_post
  def create
    unless current_user
      flash[:alert] = "Please sign in or sign up first"
      redirect_to new_user_session_path
    else
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      else
        flash.now[:alert] = "Comment has not been created"
      end
      # redirect_to post_path(@post)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end
