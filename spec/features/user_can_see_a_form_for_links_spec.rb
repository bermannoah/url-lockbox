require 'rails_helper'

describe "seeing a form for links" do
  context "the user is not logged in" do
    scenario "and does not see the form" do
      visit "/links"
      
      expect(page).to_not have_content("Add a link here")
      expect(page).to_not have_content("Submit")
    end
  end

  context "the user is logged in" do
    scenario "and does see the form" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(page).to have_content("Add a link here")
      expect(page).to have_content("Url:")
      expect(page).to have_button("Submit")
    end
  end
end