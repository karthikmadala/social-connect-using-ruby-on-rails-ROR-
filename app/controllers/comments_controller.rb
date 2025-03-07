class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]

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
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
        format.js { render layout: false } # For AJAX requests
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: 'You are not authorized to delete this comment.' }
        format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
        format.js { render js: "alert('You are not authorized to delete this comment.');" } # For AJAX
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end