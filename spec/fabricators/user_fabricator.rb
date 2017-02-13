Fabricator(:user) do
  email           "#{Faker::Internet.unique.email}"
  password_digest "#{Faker::Crypto.unique.md5}"
end
