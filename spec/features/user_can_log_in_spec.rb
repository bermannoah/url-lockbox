require "rails_helper"

describe "the user logs in" do
  scenario "correctly" do
    user = Fabricate(:user, email: "hey@example.com", password: "123456")

    visit "/"
    
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Login")

    click_on "Login"
    
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_button("Submit")
    
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    
    click_on "Submit"

    expect(page).to have_content("Welcome! You've successfully logged in.")
    expect(page).to have_content("Logout")
  end
end