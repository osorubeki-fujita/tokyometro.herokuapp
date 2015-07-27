class Railway::Line::Relation < ActiveRecord::Base
  belongs_to :main_railway_line_info , class: ::Railway::Line::Info
  belongs_to :branch_railway_line_info , class: ::Railway::Line::Info
end
