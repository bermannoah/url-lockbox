class UsersController < ApplicationController
  
  def new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
      flash[:notice] = "Welcome! You've successfully signed up!"
    else
      redirect_to '/signup'
      flash[:notice] = "Whoops, you entered something incorrectly. Try again?"
    end
  end
  
  def unauthenticated
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end