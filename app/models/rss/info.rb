class Rss::Info < ActiveRecord::Base
  belongs_to :category , class: ::Rss::Category
end