class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create, :my_posts]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @user = @post.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if @post.user == current_user
      render :edit
    else
      redirect_to @post, alert: "You are not authorized to edit this post."
    end
  end

  def update
    if @post.update(post_params)
      redirect_to user_post_path(@post.user, @post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(user_id: @post.user_id)
  end

  def my_posts
    @user = current_user
    @posts = @user.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "That doen't exist."
  end
end
