require "rails_helper"

RSpec.describe "can mark links as read", :js => :true do
  scenario "Mark a link as read" do
    user = Fabricate(:user)
    stub_logged_in_user(user)
    Link.create(url:"https://turing.io", title:"Turing", user_id: user.id)
    visit "/"
    within('.link .read-status') do
      expect(page).to have_text("False")
    end

    click_on "Mark as Read"
    
    visit "/"

    within('.link .read-status') do
      expect(page).to have_text("True")
    end
  end
end
