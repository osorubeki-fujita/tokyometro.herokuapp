class Station::Info < ActiveRecord::Base

  belongs_to :station_facility_info , class: ::Station::Facility::Info
  belongs_to :railway_line
  belongs_to :operator

  has_many :station_passenger_surveys , class: ::Station::PassengerSurvey, foreign_key: :station_info_id
  has_many :passenger_surveys , through: :station_passenger_surveys , class: ::PassengerSurvey

  has_many :connecting_railway_line_infos , class: ::ConnectingRailwayLine::Info , foreign_key: :station_info_id
  has_many :railway_lines , through: :connecting_railway_line_infos

  has_many :station_points , class: ::Station::Point , foreign_key: :station_info_id
  has_many :point_infos , through: :station_points , class: ::Point::Info

  has_many :station_stopping_pattern_infos , class: ::Station::StoppingPattern::Info , foreign_key: :station_info_id
  has_many :stopping_patterns , through: :station_stopping_pattern_infos , class: ::StoppingPattern

  has_many :station_name_aliases , class: ::Station::NameAlias

  has_many :station_timetable_fundamental_infos , class: ::Station::Timetable::FundamentalInfo , foreign_key: :station_info_id
  has_many :station_timetable_infos , through: :station_timetable_fundamental_infos , class: ::Station::Timetable::Info

  has_many :train_timetable_train_type_in_other_operator_infos , class: ::Train::Timetable::TrainTypeInOtherOperatorInfo , foreign_key: :from_station_id

  # geocoded_by :name_ja
  # after_validation :geocode

  include ::TokyoMetro::Modules::Decision::Common::Fundamental::CompareBase
  include ::TokyoMetro::Modules::Decision::Db::Operator
  include ::TokyoMetro::Modules::Decision::Db::Station::Current

  def station_infos_including_other_railway_lines
    station_facility_info.station_infos.order( :railway_line_id )
  end

  def base_station_info
    station_infos_including_other_railway_lines.first
  end

  def railway_lines_of_tokyo_metro
    ::RailwayLine.where( id: station_infos_including_other_railway_lines.pluck( :railway_line_id ) ).tokyo_metro
  end

  def latest_passenger_survey
    passenger_surveys.latest
  end

  def station_page_name
    name_in_system.underscore
  end

  def has_another_railway_lines_of_tokyo_metro?
    railway_lines_of_tokyo_metro.length > 1
  end

  def tokyo_metro?
    railway_line.tokyo_metro?
  end

  def connected_to?( railway_line_instance , only_tokyo_metro: false , include_myself: false )
    if include_myself and railway_line_id == railway_line_instance.id
      return true
    end

    railway_line_ids = ::Array.new
    if railway_line.branch_line?
      railway_line_ids << railway_line.main_railway_line_id
    end
    if only_tokyo_metro
      railway_line_ids += connecting_railway_line_infos.pluck( :railway_line_id )
    else
      railway_line_ids += station_infos_including_other_railway_lines.pluck( :railway_line_id )
    end

    return railway_line_ids.include?( railway_line_instance.id )
  end

  def name_ja_actual
    name_ja.revive_machine_dependent_character
  end

  # @!group 「駅」の属性（路面電車については「停留場」）

  [ :attribute_ja , :attribute_hira , :attribute_en , :attribute_en_short ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        railway_line.station_#{ method_name }
      end
    DEF
  end

  # @!endgroup

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
