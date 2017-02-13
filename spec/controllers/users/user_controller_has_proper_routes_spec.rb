require 'rails_helper'

describe UsersController, type: :controller do
  context "new" do
    scenario "it sends users to the right place" do
      get :new
      
      expect(response).to have_http_status(200)
    end
  end
end