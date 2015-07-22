class Railway::Direction < ActiveRecord::Base
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  include ::Association::To::Station::Info

  has_many :station_timetable_fundamental_infos , class: ::Station::Timetable::FundamentalInfo , foreign_key: :railway_direction_id
  has_many :station_timetable_infos , through: :station_timetable_fundamental_infos , class: ::Station::Timetable::Info

  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :railway_direction_id
  has_many :platform_transfer_infos , class: ::Station::Facility::Platform::TransferInfo , foreign_key: :railway_direction_id

  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :railway_direction_id

  def operator_info
    railway_line_info.operator_info
  end

  def operator_info_id
    railway_line_info.operator_info_id
  end

end
