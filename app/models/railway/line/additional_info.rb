class Railway::Line::AdditionalInfo < ActiveRecord::Base
  belongs_to :info , class: ::Railway::Line::Info
end
