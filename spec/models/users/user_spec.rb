require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:links) }
  it { should have_secure_password }
  
  it "rejects bad emails" do
    user = User.new(email: "lol", password: "123")
    expect(user).to be_invalid
  end

  it "accepts good emails" do
    user = User.new(email: "lol@lol.com", password: "123")
    expect(user).to be_valid
  end
end