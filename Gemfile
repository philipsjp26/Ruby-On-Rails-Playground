source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2"

# Use Postgres as the database for Active Record
gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'solargraph'  
  gem "spring"
end

# set up enviroment to file
gem "dotenv-rails"

# set up API grape and swagger doc
gem "grape", "~> 1.6.2"
gem "grape-middleware-logger"
gem "grape-entity"
gem "hashie"


# upload storage
gem "carrierwave"
gem "cloudinary"

# pagination
gem "kaminari"
gem "api-pagination"

# Spreadsheets
gem "caxlsx"

# scheduler
gem "rufus-scheduler"

# Background Jobs
gem "delayed_job_active_record"

# Soft delete
gem "acts_as_paranoid"

# Oauth2
gem "doorkeeper"

# Secure password
gem "bcrypt", "~> 3.1.7"

# Rest HTTP Client
gem "faraday"

# Apache Kafka Client
gem "racecar"

# NOTES : For pg_config Mac M1
# gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
