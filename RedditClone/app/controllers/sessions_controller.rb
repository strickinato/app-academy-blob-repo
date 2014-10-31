class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    username = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by_credentials(username, password)
    
    if user.nil?
      flash.now[:notice] = "Thats not a real user!"
      render :new
    else
      login!(user)
      redirect_to user_url
    end
  end
  
  def destroy
    logout!(current_user)
    
    redirect_to new_session_url
  end
  
end
