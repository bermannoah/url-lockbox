require "rails_helper"

describe "flash messages" do
  scenario "when the user correctly signs up" do
    visit "/signup"
    
    expect(page).to have_content("Signup for URL-Lockbox!")
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_content("Password Confirmation:")
    expect(page).to have_button("Submit")
    
    fill_in "user[email]", with: "cool@cool.com"
    fill_in "user[password]", with: "123456"
    fill_in "user[password_confirmation]", with: "123456"
    
    click_on "Submit"
    
    expect(page).to have_content("Welcome! You've successfully signed up!")
  end
  
  scenario "when the user correctly logs in" do
    user = Fabricate(:user, email: "cool@cool.com", password: "123456")

    visit "/login"
    
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_button("Submit")
    
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    
    click_on "Submit"
    
    expect(page).to have_content("Welcome! You've successfully logged in.")
  end
  
  scenario "when the user incorrectly signs up" do
    visit "/signup"
        
    fill_in "user[email]", with: "cool@cool.com"
    fill_in "user[password]", with: "123456"
    fill_in "user[password_confirmation]", with: "12891239812398012312321321"
    
    click_on "Submit"
    
    expect(page).to have_content("Whoops, you entered something incorrectly. Try again?")
  end

  scenario "when the user incorrectly logs in" do
    user = Fabricate(:user, email: "cool@cool.com", password: "123456")

    visit "/signup"
    
    fill_in "user[email]", with: "cool@cool.com"
    fill_in "user[password]", with: "123456"
    
    click_on "Submit"
    
    expect(page).to have_content("Whoops, you entered something incorrectly. Try again?")
  end
  
  scenario "when the user correctly logs out" do
    user = Fabricate(:user, email: "cool@cool.com", password: "123456")

    visit "/login"
    
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_button("Submit")
    
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    
    click_on "Submit"
    
    click_on "Logout"
    expect(page).to have_content("You have logged out!")
  end


end