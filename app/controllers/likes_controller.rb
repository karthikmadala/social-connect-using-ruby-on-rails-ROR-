class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    like = post.likes.find_by(user: current_user)

    if like
      like.destroy
    else
      post.likes.create(user: current_user)
    end

    redirect_to posts_path
  end
end
