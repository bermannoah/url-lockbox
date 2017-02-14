class LinksController < ApplicationController
  before_action :authorize
  
  def create
    link = params["link"]
    new_link = Link.new(url: link["url"], title: link["title"], user_id: current_user.id)
    if new_link.save
      flash[:notice] = "Link #{link["title"]} Saved!"
      redirect_to '/'
    else
      flash[:notice] = "You've saved the URL incorrectly. Try again?"
      redirect_to '/'
    end
  end
  
  def index
    @links = Link.where(user_id: current_user.id)    
  end
end
