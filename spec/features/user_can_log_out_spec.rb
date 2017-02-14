require "rails_helper"

describe "the user logs out" do
  scenario "correctly" do
    user = Fabricate(:user, email: "hey@example.com", password: "123456")

    visit "/"
    
    click_on "Login"
        
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    
    click_on "Submit"
    
    expect(page).to have_content("Logout")
    
    click_on "Logout"
    
    expect(page).to have_content("You have logged out!")
  end
end