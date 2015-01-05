class RssCategory < ActiveRecord::Base
  has_many :rsses
end