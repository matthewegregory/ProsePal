class PostsController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :set_post, except: [:index, :new, :create, :my_posts]
  before_action :authenticate_user!, except: [:index, :show]
  # skip_after_action :turbostream

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @like = current_user.likes.find_by(post_id: @post.id) || Like.new
    @comments = @post.comments
    @new_comment = @post.comments.new
    @post_comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new
    @post.tags.build
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    # Parse the tag_list manually before saving
    tag_list = params[:post][:tag_list].split(",").map(&:strip)
    @post.tag_list = tag_list

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
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
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(@user)
  end

  def my_posts
    @posts = current_user.posts.order(created_at: :desc)
  end

  private

  def set_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The post you're looking for doesn't exist."
    redirect_to posts_path # Redirect to the index page for posts
  end

  def post_params
    params.require(:post).permit(:title, :text, :tag_list)
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "You must be signed in to perform this action."
      redirect_to new_user_session_path
    end
  end
end
