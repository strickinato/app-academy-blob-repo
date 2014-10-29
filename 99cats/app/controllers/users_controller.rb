class UsersController < ApplicationController
  before_action :check_login
  
  
  def create
    @user = User.new(user_params)
    @user.password = user_params[:password_digest]
    if @user.save
      login_user!
    else
      flash[:notice] = @user.errors.full_messages
      render :new
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password_digest)
  end
  
  def check_login
    redirect_to cats_url if current_user
  end
  
end