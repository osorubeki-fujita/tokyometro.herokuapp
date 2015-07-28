class Train::Type::ColorInfo < ActiveRecord::Base
  has_many :infos , class: ::Train::Type::Info , foreign_key: :color_info_id

  belongs_to :color_info , class: ::Design::Color::Info
  belongs_to :bgcolor_info , class: ::Design::Color::Info

  def color
    color_info.hex_color
  end

  def bgcolor
    bgcolor_info.hex_color
  end

end
