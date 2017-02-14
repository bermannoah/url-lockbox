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
      flash[:notice] = "Whoops, you entered something incorrectly. Try again?"
      redirect_to '/signup'
    end
  end
  
  def unauthenticated
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end