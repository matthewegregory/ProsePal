class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @likable = find_likable
    @like = current_user.likes.new(likeable: @likable)

    respond_to do |format|
      if @like.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('likes', partial: 'likes/like', locals: { like: @like }) }
      else
        flash.now[:alert] = "Failed to like." # Setting the flash message
        format.turbo_stream { render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash') }
        format.html { render 'posts/show' } # Render the posts/show.html.erb view with the validation errors
      end
    end
  end

  def destroy
    @likable = find_likable
    @like = current_user.likes.find_by(likeable: @likable)
    @like.destroy
    redirect_back fallback_location: root_path, notice: "Unliked!"
  end

  private

  def find_likable
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end
end
