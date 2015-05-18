class Point::Category < ActiveRecord::Base

  has_many :infos , class: ::Point::Info , foreign_key: :category_id

  def exit?
    name_ja == "出入口"
  end

end
