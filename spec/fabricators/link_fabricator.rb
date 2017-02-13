Fabricator(:link) do
  url           "#{Faker::Internet.unique.url}"
  title "#{Faker::Hacker.say_something_smart}"
end
