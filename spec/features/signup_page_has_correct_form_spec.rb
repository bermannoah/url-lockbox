require "rails_helper"

describe "there is a signup form on the new page" do
  scenario "and user can see expected fields and buttons" do
    visit "/signup"
    
    expect(page).to have_content("Signup for URL-Lockbox!")
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_content("Password Confirmation:")
    expect(page).to have_button("Submit")
  end
end