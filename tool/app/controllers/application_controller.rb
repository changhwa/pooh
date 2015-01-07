class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def saveSessionStore (user)
    session[:email] = user[:email]
    session[:nick] = user[:nick]
    session[:id] = user[:id]
  end

  def isLogin
    p session[:email]
    if session[:email] == nil
      redirect_to '/'
    end
  end
end
