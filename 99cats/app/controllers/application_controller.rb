class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  def login_user!
    user_exists = User.find_by_credentials(user_params[:username], user_params[:password_digest])
    if user_exists.nil?
      @user = User.new(user_params)
      flash.now[:notice] = @user.errors.full_messages
      render :new
    else
      user_exists.reset_session_token!
      session[:session_token] = user_exists.session_token
      redirect_to cats_url
    end
  end
    
  
end
