Fabricator(:link) do
  url           "#{Faker::Internet.url}"
  title "#{Faker::Hacker.say_something_smart}"
end
