class Train::Timetable::ArrivalInfo < ActiveRecord::Base
  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :arrival_info_id
  include ::Association::To::Station::Info

  def platform_number_with_parentheses
    "(#{ platform_number })"
  end

end
