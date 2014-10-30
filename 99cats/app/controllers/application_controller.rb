class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def current_user
    #Logic to find new user
    user_agent = request.env["HTTP_USER_AGENT"]
    remote_address = request.env["REMOTE_ADDR"]
    auth_token = session[:session_token]
    search_tokens = [auth_token, user_agent, remote_address]
    thing = Login.find_by_auth_token_and_user_agent_and_remote_address(*search_tokens)
    #fail
    
    #WORKING CODE
    User.find_by_session_token(session[:session_token])
    #thing.user
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
      create_login(user_exists.id, user_exists.session_token)
      redirect_to cats_url
    end
  end
    
  def create_login(user_id, auth_token)
    #Used to hopefully create login session for a new device
    user_agent = request.env["HTTP_USER_AGENT"]
    remote_address = request.env["REMOTE_ADDR"]

    @login = Login.create!(
      user_id: user_id, 
      user_agent: user_agent, 
      remote_address: remote_address,
      auth_token: auth_token
      )
  end
end
