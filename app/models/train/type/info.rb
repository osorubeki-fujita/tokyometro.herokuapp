class Train::Type::Info < ActiveRecord::Base

  include ::TokyoMetro::Modules::Name::Common::TrainType::CssClass
  include ::TokyoMetro::Modules::Name::Common::TrainType::ColorBasename

  belongs_to :in_api , class: ::Train::Type::InApi
  belongs_to :railway_line_info , class: ::Railway::Line::Info

  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :train_type_info_in_this_station_id
  has_many :travel_time_infos , class: ::Railway::Line::TravelTimeInfo , foreign_key: :train_type_info_id

  has_many :train_type_stopping_patterns , class: ::Train::Type::StoppingPattern , foreign_key: :train_type_info_id
  has_many :stopping_patterns , through: :train_type_stopping_patterns

  has_many :train_timetable_train_type_in_other_operator_infos , class: ::Train::Timetable::TrainTypeInOtherOperatorInfo , foreign_key: :train_type_info_id
  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :train_type_info_id


  scope :select_colored_if_exist , -> {
    colored = select( &:colored? )
    if colored.present?
      colored
    else
      select( &:normal? )
    end
  }

  scope :defined , -> {
    where.not( same_as: "custom.TrainType:Undefined" )
  }

  def normal?
    /Normal/ === same_as
  end

  def colored?
    /Colored\Z/ === same_as
  end

  def operator_id
    railway_line.operator_id
  end

  def has_color_infos?
    color.present? and bgcolor.present?
  end

end
