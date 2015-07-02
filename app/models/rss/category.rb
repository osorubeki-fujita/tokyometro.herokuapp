class Rss::Category < ActiveRecord::Base
  has_many :infos , class: ::Rss::Info
end