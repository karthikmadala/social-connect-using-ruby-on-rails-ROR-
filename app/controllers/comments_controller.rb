class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to posts_path, notice: "Comment added!"
    else
      redirect_to posts_path, alert: "Comment can't be empty."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
