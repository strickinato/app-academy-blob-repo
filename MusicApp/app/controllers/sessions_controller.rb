class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["cannot find this user"]
      render :new
    else
      login!(user)
      redirect_to bands_url
    end

  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    user = User.new
    logout!(user)
    redirect_to new_session_url
  end
end
