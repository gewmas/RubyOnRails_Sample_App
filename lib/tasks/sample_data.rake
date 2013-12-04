# This defines a task db:populate that creates an example user with name and email address replicating our previous one, and then makes 99 more.

# $ bundle exec rake db:reset
# $ bundle exec rake db:populate
# $ bundle exec rake test:prepare

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
     email: "example@railstutorial.org",
     password: "foobar",
     password_confirmation: "foobar",
     admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
       email: email,
       password: password,
       password_confirmation: password)
      # admin: false (default)
    end
  end
end