class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, except: [:home]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    @user = current_user
    puts current_user.inspect
    render 'layouts/home'
  end

  def sign_out_user
    sign_out current_user
    redirect_to root_path, notice: 'You have been signed out successfully.'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :username, :first_name, :last_name, :location, :birthdate, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :username, :first_name, :last_name, :location, :birthdate, :bio])
  end
end
