class Station < ActiveRecord::Base
  has_many :station_passenger_surveys
  has_many :passenger_surveys , through: :station_passenger_surveys

  belongs_to :station_facility
  belongs_to :railway_line

  has_many :connecting_railway_lines
  has_many :railway_lines , through: :connecting_railway_lines
  has_many :operators , through: :railway_lines

  has_many :station_points
  has_many :points , through: :station_points

  has_many :station_stopping_patterns
  has_many :stopping_patterns , through: :station_stopping_patterns

  has_many :station_aliases

  has_many :station_timetable_fundamental_infos
  has_many :station_timetables , through: :station_timetable_fundamental_infos

  # geocoded_by :name_ja
  # after_validation :geocode

  include ::TokyoMetro::Modules::Db::Decision::Operator

  def stations_including_other_railway_lines
    station_facility.stations.order( :railway_line_id )
  end

  def base_station
    stations_including_other_railway_lines.first
  end

  def railway_lines_of_tokyo_metro
    stations_including_other_railway_lines.includes( :railway_line ).order( railway_line_id: :asc ).map( &:railway_line ).select( &:tokyo_metro? )
  end

  def latest_passenger_survey
    passenger_surveys.latest
  end

  def station_page_name
    name_in_system.underscore
  end

  def at_ayase?
    [ "odpt.Station:TokyoMetro.Chiyoda.Ayase" , "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" ].include?( same_as )
  end

  [ :attribute_ja , :attribute_hira , :attribute_en , :attribute_en_short ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        railway_line.station_#{ method_name }
      end
    DEF
  end

  # 特定の駅のインスタンスを取得する
  # @param station_name_ja [String] 駅名（日本語表記）
  scope :of , ->( station_name_ja ) {
    find_by( name_ja: station_name_ja )
  }

  # 特定の路線の駅を取得する
  # @param railway_line_ids [Integer or Array] 路線の id の配列
  scope :in_railway_line , ->( railway_line_ids ) {
    where( railway_line_id: railway_line_ids )
  }

  scope :tokyo_metro , ->( tokyo_metro_id = nil ) {
    if tokyo_metro_id.nil?
      tokyo_metro_id = ::Operator.id_of_tokyo_metro
    end
    where( operator_id: tokyo_metro_id )
  }

  scope :find_tokyo_metro_station_by_name_in_system , ->( name_in_system , tokyo_metro_id = nil ) {
    if tokyo_metro_id.nil?
      tokyo_metro_id = ::Operator.id_of_tokyo_metro
    end
    find_by( name_in_system: name_in_system , operator_id: tokyo_metro_id )
  }

  scope :station_number_in_tokyo_metro_by_name_in_system , ->( name_in_system , tokyo_metro_id = nil ) {
    if tokyo_metro_id.nil?
      tokyo_metro_id = ::Operator.id_of_tokyo_metro
    end
    where( name_in_system: name_in_system , operator_id: tokyo_metro_id ).map( &:station_code )
  }
end