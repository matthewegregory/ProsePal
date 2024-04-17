class SearchController < ApplicationController
  def index
    @query = params[:query]
    @posts = Post.search(@query)
    @users = User.search(@query)
    
    # You can add search logic for other models like comments, tags, etc.
  end
end
