class UsersController < ApplicationController
  def show
    @user = current_user
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url
    else
      flash.now[:notice] = @user.errors.full_messages
      render :new
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
