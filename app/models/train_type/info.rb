class TrainType::Info < ActiveRecord::Base

  include ::TokyoMetro::Modules::Common::Info::TrainType::CssClass

  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :train_type_info_in_this_station_id
  has_many :travel_time_infos , class: ::TravelTimeInfo , foreign_key: :train_type_info_id

  has_many :train_type_stopping_patterns , class: ::TrainType::StoppingPattern , foreign_key: :train_type_info_id
  has_many :stopping_patterns , through: :train_type_stopping_patterns

  has_many :train_timetable_train_type_info_in_other_operators , class: ::TrainTimetableTrainTypeInfoInOtherOperator , foreign_key: :train_type_info_id

  belongs_to :in_api , class: ::TrainType::InApi
  belongs_to :railway_line

  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :train_type_info_in_this_station_id

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

  def train_type_in_api
    in_api
  end

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
