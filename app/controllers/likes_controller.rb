class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      @like.update_likes_counter
      flash[:notice] = 'Like added'
    else
      flash[:error] = 'Sorry! Something went wrong!'
    end

    redirect_to post_path(@post)
  end
end
