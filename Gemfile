source 'http://rubygems.org'
# source 'https://rubygems.org'

ruby '2.1.5'

# -------- Ruby on Rails

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

#-------- development 環境

# Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3'
  # gem 'pg'

  gem 'sinatra' # Webアプリケーションフレームワーク
  gem 'sequel'
  gem 'bullet'
  gem "rails-erd"
  gem 'quiet_assets' , '~> 1.0.3'

  gem 'rspec'
  gem 'rspec-rails'

  gem 'yard', '0.8.7.6'

  # Use Capistrano for deployment
  # gem 'capistrano-rails'
end

#-------- production 環境

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem "activerecord-postgresql-adapter"
end

#-------- test 環境

group :test do
  # gem 'rspec'
  # gem 'rspec-rails'
end

#--------

gem 'yaml_db'
gem 'taps'

gem 'font-awesome-sass'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 5.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '>= 4.0.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2.5'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

gem 'haml-rails'
gem 'httpclient'
gem 'moji'
gem 'holiday_jp'

gem 'json' # JSONを扱うライブラリ

gem 'jquery-ui-rails' , '~> 5.0.3'
gem 'gmaps4rails'

gem 'whenever', :require => false

gem 'draper'

# gem 'feedjira'
# gem 'geocoder'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.9'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]

#--------

# gem 'rails-Graphviz'

# gem 'rest-client' # REST-APIを簡易に扱うライブラリ
# gem 'thin' # Rubyを実行する軽量なWebサーバー
# gem 'haml'
# gem 'sass'

# require 'psych'

gem 'kaminari'

#--------

gem 'pry-rails' , group: [ :development , :test ]
gem 'pry-byebug' , group: [ :development , :test ]
gem 'hirb' , group: [ :development , :test ]
gem 'hirb-unicode' , group: [ :development , :test ]
gem 'better_errors' , group: [ :development , :test ]
gem 'binding_of_caller' , group: [ :development , :test ]