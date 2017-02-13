require "rails_helper"

describe "user can sign up" do
  scenario "and user can see expected fields and buttons" do
    visit "/signup"
    
    expect(page).to have_content("Signup for URL-Lockbox!")
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_content("Password Confirmation:")
    expect(page).to have_button("Submit")
  end
  
  scenario "the user correctly signs up" do
    visit "/signup"
    
    expect(page).to have_content("Signup")
    expect(page).to have_content("Login")
    
    fill_in "user[email]", with: "cool@cool.com"
    fill_in "user[password]", with: "123456"
    fill_in "user[password_confirmation]", with: "123456"
    
    click_on "Submit"
    
    expect(page).to have_content("Welcome! You've successfully signed up!")
  end

end