class Railway::Line::CodeInfo < ActiveRecord::Base

  has_many :info_code_infos , class: ::Railway::Line::InfoCodeInfo , foreign_key: :code_id
  has_many :infos , class: ::Railway::Line::Info , through: :info_code_infos

end
