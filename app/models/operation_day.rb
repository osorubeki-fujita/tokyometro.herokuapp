class OperationDay < ActiveRecord::Base
  has_many :women_only_car_info , class: ::Railway::Line::WomenOnlyCarInfo , foreign_key: :operation_day_id
  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :operation_day_id

  def holiday?
    [ "Holiday" , "Saturday and Holiday" ].include?( name_en )
  end

end
