source 'https://rubygems.org'

# source 'https://rubygems.org'
# source "http://rubygems.org/"
# source "http://production.cf.rubygems.org"

# ruby '2.2.2'
ruby '2.1.6'

gem 'rack' , '1.6.2'

# -------- Ruby on Rails

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

#-------- original gems

gem 'metalic_ratio' , '>= 0.1.7'

gem 'positive_support' , '>= 0.3.0'
gem 'positive_string_support' , '>= 0.1.3'

gem 'required_files' , '>= 0.2.6' , group: [:development, :test]

gem 'tokyo_metro' , ">= 0.8.20"

#-------- development 環境

# Use sqlite3 as the database for Active Record
group :development do

  #-------- [begin] original gems

  gem 'deplo' , '>= 0.1.4'

  #-------- [end] original gems

  gem 'sqlite3'
  # gem 'pg'

  gem 'sinatra' # Webアプリケーションフレームワーク
  gem 'sequel'
  gem 'bullet'
  gem "rails-erd"
  gem 'quiet_assets' , '~> 1.0.3'

  gem 'yard', '0.8.7.6'

  # Use Capistrano for deployment
  gem 'capistrano-rails'
end

#-------- production 環境

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem "activerecord-postgresql-adapter"
  gem "lograge"
end

#-------- RSpec

gem 'rspec' , group: [:development, :test]
gem 'rspec-rails' , group: [:development, :test]


#--------

gem 'yaml_db'
gem 'taps'
gem "yui-compressor"

gem 'font-awesome-sass'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 5.0.0'

# This does not work
# gem 'sass_rails_patch'

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
gem 'sdoc', '~> 0.4.0', group: :doc

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

gem 'haml-rails'
gem 'httpclient'
gem 'jquery-turbolinks'


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

#-------- Gems below are not working on Windows
# gem 'spring' , group: [ :development , :test ]
# gem 'spring-commands-rspec' , group: [ :development , :test ]
