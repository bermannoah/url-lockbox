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

    scenario "and submits a link that can be clicked" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "http://www.google.com"
      fill_in "link[title]", with: "Cool!"
      
      click_on "Submit"
      
      expect(Link.count).to eq(1)
      expect(page).to have_link('http://www.google.com', href: 'http://www.google.com')
      expect(find_link('http://www.google.com')[:target]).to eq('_blank')
    end

    scenario "and submits a link without a title" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "http://www.google.com"
      
      click_on "Submit"
      
      expect(Link.count).to eq(0)
      expect(page).to have_content("You've saved the URL incorrectly. Try again?")
    end

    scenario "and submits an invalid link" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "linksaresogood"
      fill_in "link[title]", with: "Cool!"
      
      click_on "Submit"
      
      expect(Link.count).to eq(0)
      expect(page).to have_content("You've saved the URL incorrectly. Try again?")
    end

    scenario "and submits a more subtly invalid link" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "http://linksaresogood"
      fill_in "link[title]", with: "Cool!"
      
      click_on "Submit"
      
      expect(Link.count).to eq(0)
      expect(page).to have_content("You've saved the URL incorrectly. Try again?")
    end

    scenario "and submits a valid but unorthodox link" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "http://hello.world.com"
      fill_in "link[title]", with: "Cool!"
      
      click_on "Submit"
      
      expect(Link.count).to eq(1)
      expect(page).to have_content("http://hello.world.com")
    end

    scenario "and submits a valid but unusual link" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      
      fill_in "link[url]", with: "https://hello.world.co.uk"
      fill_in "link[title]", with: "Cool!"
      
      click_on "Submit"
      
      expect(Link.count).to eq(1)
      expect(page).to have_content("https://hello.world.co.uk")
    end

    scenario "and sees the link on the links page" do
      user = Fabricate(:user)
      stub_logged_in_user(user)

      visit "/links"
      
      expect(Link.count).to eq(0)
      link = Fabricate.build(:link, title: "good")
      expect(page).to_not have_content(link.title)
      
      fill_in "link[url]", with: link.url
      fill_in "link[title]", with: link.title
      
      click_on "Submit"

      expect(Link.count).to eq(1)
      expect(page).to have_content(link.title)
      expect(page).to have_content(link.url)
      expect(page).to have_content("False")
      expect(page).to have_css("#good-switch")
      
    end

    scenario "and sees multiple links on the links page" do
      user = Fabricate(:user)
      link_1 = Fabricate(:link, user_id: user.id, title: "great")
      link_2 = Fabricate(:link, user_id: user.id, title: "awesome")
      link_3 = Fabricate(:link, user_id: user.id, title: "really good")
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
      expect(page).to have_css("#great-switch")
      expect(page).to have_css("#awesome-switch")
      expect(page).to have_css("#really-good-switch")
      expect(page).to have_content("False")
    end

    scenario "and sees only their own links on links page" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user, email: "roflmao@google.com")
      link_1 = Fabricate(:link, user_id: user_1.id, title: "lol")
      link_2 = Fabricate(:link, user_id: user_2.id, title: "roflmao")
      link_3 = Fabricate(:link, user_id: user_2.id, title: "idk my bff jill")
      link_4 = Fabricate(:link, user_id: user_1.id, title: "zombotron")
      link_5 = Fabricate(:link, user_id: user_1.id, title: "badger")
      stub_logged_in_user(user_1)

      visit "/links"
      
      expect(Link.count).to eq(5)
      expect(page).to have_content(link_1.title)
      expect(page).to_not have_content(link_2.title)
      expect(page).to_not have_content(link_3.title)
      expect(page).to have_content(link_4.title)
      expect(page).to have_content(link_5.title)
      expect(page).to have_content("False")
    end

    scenario "and sees the correct status when a link's status is changed" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user, email: "roflmao@google.com")
      link_1 = Fabricate(:link, user_id: user_1.id, title: "lol")
      link_2 = Fabricate(:link, user_id: user_2.id, title: "roflmao")
      link_3 = Fabricate(:link, user_id: user_2.id, title: "idk my bff jill")
      link_4 = Fabricate(:link, user_id: user_1.id, title: "zombotron")
      link_5 = Fabricate(:link, user_id: user_1.id, title: "badger")
      stub_logged_in_user(user_1)

      visit "/links"
      
      expect(Link.count).to eq(5)
      expect(page).to have_content(link_1.title)
      expect(page).to_not have_content(link_2.title)
      expect(page).to_not have_content(link_3.title)
      expect(page).to have_content(link_4.title)
      expect(page).to have_content(link_5.title)
      expect(page).to_not have_content("True")
      
      link_1.read = "True"
      link_1.save
      
      visit "/links"
      expect(page).to have_content("True")
    end

  end
end