class Station::Info < ActiveRecord::Base
  has_many :station_passenger_surveys , foreign_key: :station_info_id
  has_many :passenger_surveys , through: :station_passenger_surveys

  belongs_to :station_facility
  belongs_to :railway_line
  belongs_to :operator

  has_many :connecting_railway_lines , class: ::ConnectingRailwayLine , foreign_key: :station_info_id
  has_many :railway_lines , through: :connecting_railway_lines

  has_many :station_points
  has_many :points , through: :station_points

  has_many :station_stopping_patterns
  has_many :stopping_patterns , through: :station_stopping_patterns

  has_many :station_name_aliases

  has_many :station_timetable_fundamental_infos
  has_many :station_timetables , through: :station_timetable_fundamental_infos

  # geocoded_by :name_ja
  # after_validation :geocode

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Db::Decision::Operator
  include ::TokyoMetro::Modules::Db::Decision::CurrentStation

  def station_infos_including_other_railway_lines
    station_facility.station_infos.order( :railway_line_id )
  end

  def base_station_info
    station_infos_including_other_railway_lines.first
  end

  def railway_lines_of_tokyo_metro
    station_infos_including_other_railway_lines.includes( :railway_line ).order( railway_line_id: :asc ).map( &:railway_line ).select( &:tokyo_metro? )
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

  def has_another_railway_lines_of_tokyo_metro?
    railway_lines_of_tokyo_metro.length > 1
  end

  [ :attribute_ja , :attribute_hira , :attribute_en , :attribute_en_short ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        railway_line.station_#{ method_name }
      end
    DEF
  end

  default_scope {
   order( railway_line_id: :asc ).order( index_in_railway_line: :asc )
  }

  # 特定の路線の駅を取得する
  # @param railway_line_ids [Integer or Array] 路線の id の配列
  scope :in_railway_line , ->( railway_line_ids ) {
    where( railway_line_id: railway_line_ids )
  }

  scope :select_tokyo_metro , ->( tokyo_metro_id = nil ) {
    if tokyo_metro_id.nil?
      tokyo_metro_id = ::Operator.find_by( same_as: "odpt.Operator:TokyoMetro" ).id
    else
      unless tokyo_metro_id.integer?
        raise "Error"
      end
    end
    where( operator_id: tokyo_metro_id )
  }
  
  scope :tokyo_metro , ->( tokyo_metro_id = nil ) {
    select_tokyo_metro( tokyo_metro_id )
  }
end