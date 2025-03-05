class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    # @posts = Post.includes(:user, :photos, :likes, :comments).order(created_at: :desc)
    @posts = Post.includes(:user, :likes, :comments).with_attached_photos.order(created_at: :desc)

    @post = Post.new  # Add this line
  end


  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post created successfully!"
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post updated!"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post deleted."
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, photos: [])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
