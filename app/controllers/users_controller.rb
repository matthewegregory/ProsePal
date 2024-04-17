class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if params[:id] == "sign_out"
      sign_out_user
    else
      @user = User.find(params[:id])
    end
  end

  def sign_out_user
    sign_out current_user
    redirect_to root_path, notice: 'You have been signed out successfully.'
  end
end
