class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def login!(user)
    session[:session_token] = user.session_token
  end
  
  def logout!(user)
    user.session_token = user.class.generate_session_token
    session[:session_token] = nil
    nil
  end
  
  def current_user
    @current_user = User.find_by_session_token(session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    redirect_to new_session_url unless logged_in? 
    
  end
  
  def is_a_moderator
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless @sub.moderator.id == current_user.id
  end
end
