class Railway::Line::Code < ActiveRecord::Base

  has_many :info_codes , class: ::Railway::Line::InfoCode , foreign_key: :code_id
  has_many :infos , class: ::Railway::Line::Info , through: :info_codes

end
