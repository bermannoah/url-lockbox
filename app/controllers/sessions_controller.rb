class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
      flash[:notice] = "Welcome! You've successfully logged in."
    else
      flash[:notice] = "You've entered something wrong. Try again?"
      redirect_to '/login'
    end
  end
  
  def destroy
    session.destroy
    redirect_to '/login'
    flash[:notice] = "You've logged out!"
  end
  
end