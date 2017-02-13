class LinksController < ApplicationController
  before_action :authorize
  
  def create
    link = params["link"]
    if Link.create!(url: link["url"], title: link["title"])
      redirect_to '/'
      flash[:notice] = "Link #{link["title"]} Saved!"
    else
      flash[:notice] = "You've entered the URL incorrectly. Try again?"
    end
  end
end
