class SessionsController < ApplicationController
  skip_before_action :check_login, only: [:destroy]
  
  def create    
    login_user!
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password_digest)
  end

  def check_login
    redirect_to cats_url if current_user
  end

end
