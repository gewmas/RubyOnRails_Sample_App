source 'https://rubygems.org'
ruby '2.7.0'
# ruby-gemset=railstutorial_rails_4_0

gem 'rails', '6.0.0'

gem 'bcrypt-ruby', '>=3.1.2'
gem 'bootstrap-sass', '>=3.2.2.0'
gem 'bootstrap-will_paginate', '>=0.0.9'
gem 'coffee-rails', '>=4.0.1'
gem 'faker', '>=1.1.2' # Faker gem to the Gemfile, which will allow us to make sample users with semi-realistic names and email addresses
gem 'jbuilder', '>=1.0.2'
gem 'jquery-rails', '>=3.0.4'
gem 'responders'
gem 'sass-rails', '>=4.0.1'
gem 'turbolinks', '>=1.1.1'
gem 'uglifier', '>=2.1.1'
gem 'will_paginate', '>=3.0.4' # Including will_paginate in the Gemfile.

group :production do
  gem 'pg', '>=0.15.1'
  gem 'rails_12factor', '>=0.0.2'
end

group :development, :test do
  gem 'rspec-rails', '~>4.0'
  gem 'sqlite3', '>=1.3.8'

  # The following optional lines are part of the advanced setup.
  gem 'guard-rspec', '>=2.5.0'
  # gem 'spork-rails', '>=4.0.0'
  gem 'childprocess', '>=0.3.6'
  gem 'guard-spork', '>=1.5.0'
end

group :test do
  gem 'byebug'
  gem 'capybara', '>=2.1.0'
  gem 'factory_bot_rails'
  gem 'rspec-its'
  gem 'selenium-webdriver', '>=2.35.1'

  # Cucumber
  gem 'cucumber-rails', '>=1.4.0', require: false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'

  # Uncomment this line on OS X.
  gem 'growl', '>=1.0.3'

  # Uncomment these lines on Linux.
  # gem 'libnotify', '0.8.0'

  # Uncomment these lines on Windows.
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.2'
  # gem 'wdm', '0.1.0'
end

group :doc do
  gem 'sdoc', '>=0.3.20', require: false
end
