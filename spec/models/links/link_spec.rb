require 'rails_helper'

describe Link, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  it { should belong_to(:user) }

  it "rejects bad links" do
    link = Link.new(url: "wfwe", title: "whoops")
    expect(link).to be_invalid
  end

  it "rejects more subtly bad links" do
    link = Link.new(url: "http://lol", title: "whoops")
    expect(link).to be_invalid
  end

  it "rejects even more subtly bad links" do
    link = Link.new(url: "heehee.com", title: "whoops")
    expect(link).to be_invalid
  end

  it "accepts properly formatted links" do
    link = Link.new(url: "http://heehee.com", title: "whoops")
    expect(link).to be_valid
  end

  it "accepts properly formatted and specific links" do
    link = Link.new(url: "http://heehee.com/cool_image.jpg", title: "whoops")
    expect(link).to be_valid
  end

  it "accepts properly formatted and specific links with subdomains" do
    link = Link.new(url: "http://whoa.heehee.com/cool_image.jpg", title: "whoops")
    expect(link).to be_valid
  end
end