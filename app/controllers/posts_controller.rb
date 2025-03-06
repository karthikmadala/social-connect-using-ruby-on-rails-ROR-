class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.includes(:user, :likes, :comments).with_attached_photos.order(created_at: :desc).page(params[:page]).per(10)
    @post = Post.new
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @post.extract_mentions
      ActionCable.server.broadcast "posts", post: render_to_string(partial: "posts/post", locals: { post: @post })
      respond_to do |format|
        format.html { redirect_to posts_path, notice: "Post created!" }
        format.js { render js: "prependPost('#{j render_to_string(partial: 'posts/post', locals: { post: @post })}');" }
      end
    else
      @posts = Post.includes(:user, :likes, :comments).with_attached_photos.order(created_at: :desc).page(params[:page]).per(10)
      flash.now[:alert] = "Post could not be created. Please check the errors."
      render :index
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to posts_path, notice: "Post updated!" }
        format.js { render js: "updatePost('#{j render_to_string(partial: 'posts/post', locals: { post: @post })}', #{@post.id});" }
      end
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post deleted." }
      format.js { render js: "document.getElementById('post-#{@post.id}').remove();" }
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:title, :content, :publish_at, photos: [], media_files: [])
  end
end
