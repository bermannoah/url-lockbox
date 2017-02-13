class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def read_status(link)
    if link.read
      "True"
    else
      "False"
    end
  end
  
  helper_method :current_user
  helper_method :read_status
  
  def authorize
    redirect_to '/home' unless current_user
  end
  
end
