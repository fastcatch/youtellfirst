source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '~> 3.2.13'

gem 'sqlite3', group: [:development, :test]

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'bootstrap-sass'
gem 'jquery-rails'

gem 'figaro', '>= 0.5.3'
gem 'devise'

gem 'simple_form'
gem 'capistrano'

group :development, :test do
  gem 'quiet_assets'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'better_errors', '>= 0.3.2'
  gem 'binding_of_caller', '>= 0.6.8'
end

gem 'rspec-rails', group: [:development, :test]
group :test do
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
end