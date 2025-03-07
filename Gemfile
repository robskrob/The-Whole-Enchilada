source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.10'

gem 'rails', '~> 6.0.1'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '5.1.1'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'haml', '~> 5.0', '>= 5.0.4'
gem 'pg', '1.2.3'
gem 'rtesseract', '3.1'
gem 'sidekiq', '6.0.6'
gem 'dotenv-rails', '2.7.5'
gem 'devise', '4.7.1'
gem 'letter_opener', '1.7.0'
gem "aws-ses-v4", require: "aws/ses"

gem 'pagy', '3.12.0'

gem 'rollbar', '3.2.0'

gem 'searchkick', '~> 5.1'
gem 'elasticsearch', '7.17.7'


group :production do
  gem 'aws-sdk-s3', '1.61.2'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'awesome_print'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "tailwindcss-rails", "~> 0.3.3"
