class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user: current_user)

    if like
      like.destroy
    else
      @post.likes.create(user: current_user)
    end

    respond_to do |format|
      format.html { redirect_to posts_path } # Fallback for non-JS requests
      format.js # This will render `create.js.erb`
    end
  end
end
