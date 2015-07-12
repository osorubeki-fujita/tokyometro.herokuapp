class TrainType < ActiveRecord::Base

  include ::TokyoMetro::Modules::Common::Info::TrainType::CssClass

  has_many :train_times
  has_many :travel_time_infos
  has_many :train_type_stopping_patterns
  has_many :stopping_patterns , through: :train_type_stopping_patterns

  belongs_to :train_type_in_api
  belongs_to :railway_line

  has_many :station_train_times , class: ::Station::TrainTime , foreign_key: :train_type_in_this_station_id

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

  def in_api
    train_type_in_api
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
