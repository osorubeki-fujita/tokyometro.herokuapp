class PointCategory < ActiveRecord::Base
  has_many :points

  def name_en
    case name_ja
    when "出入口"
      "Exit"
    else
      ""
    end
  end

  def exit?
    name_ja == "出入口"
  end

end