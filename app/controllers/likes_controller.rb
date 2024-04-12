class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)

    if @like.save
      @post.increment!(:likes_counter)
      redirect_to user_post_path(@post.user_id, @post), notice: 'You liked the post!'
    else
      redirect_to user_post_path(@post.user_id, @post), alert: 'You have already liked this post.'
    end
  end
end
