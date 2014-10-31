class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?


  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!(user)
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    unless logged_in?
      flash[:notice] = ["Must be logged in to access"]
      redirect_to new_session_url
    end
  end
end
