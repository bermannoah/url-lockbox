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

    scenario "and submits a link" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "http://www.google.com"
      fill_in "link[title]", with: "Cool!"
      
      click_on "Submit"
      
      expect(Link.count).to eq(1)
    end

    scenario "and sees the link on the links page" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      link = Fabricate.build(:link)
      expect(page).to_not have_content(link.title)
      
      fill_in "link[url]", with: link.url
      fill_in "link[title]", with: link.title
      
      click_on "Submit"

      expect(Link.count).to eq(1)
      expect(page).to have_content(link.title)
      expect(page).to have_content(link.url)
      expect(page).to have_content("Unread")
    end

    scenario "and sees multiple links on the links page" do
      user = Fabricate(:user)
      link_1 = Fabricate(:link, user_id: user.id)
      link_2 = Fabricate(:link, user_id: user.id)
      link_3 = Fabricate(:link, user_id: user.id)
      link_4 = Fabricate(:link, user_id: user.id)
      link_5 = Fabricate(:link, user_id: user.id)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(5)
      expect(page).to have_content(link_1.title)
      expect(page).to have_content(link_2.url)
      expect(page).to have_content(link_3.url)
      expect(page).to have_content(link_4.url)
      expect(page).to have_content(link_5.url)
      expect(page).to have_content("Unread")
    end
  end
end