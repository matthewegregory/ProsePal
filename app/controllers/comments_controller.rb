class CommentsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!, only: [:create]

  def new
    @user = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      # Handle validation errors
      @comments = @post.comments.reload
      render 'posts/show'
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
