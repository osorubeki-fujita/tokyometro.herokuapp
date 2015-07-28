class Railway::Line::CodeInfo < ActiveRecord::Base

  has_many :info_code_infos , class: ::Railway::Line::InfoCodeInfo , foreign_key: :code_info_id
  has_many :infos , class: ::Railway::Line::Info , through: :info_code_infos


  belongs_to :color_info , class: ::Design::Color::Info

  def color
    color_info.hex_color
  end


end
