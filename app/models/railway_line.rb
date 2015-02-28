class RailwayLine < ActiveRecord::Base

  belongs_to :operator
  has_many :stations
  has_many :station_facilities , through: :stations
  has_many :women_only_car_infos
  has_many :travel_time_infos
  has_many :railway_directions

  has_many :connecting_railway_lines
  # has_many :station_facilities , through: :connecting_railway_lines

  has_many :station_timetable_fundamental_infos
  has_many :station_timetables , through: :station_timetable_fundamental_infos

  has_many :train_timetables
  has_many :train_types

  has_many :train_informations
  has_many :train_information_olds

  has_many :train_locations
  has_many :train_location_olds

  include ::TokyoMetro::Modules::Common::Info::RailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewRailwayLine
  include ::TokyoMetro::Modules::Db::Decision::Operator

  default_scope {
    order( index: :desc )
  }

  scope :select_tokyo_metro , ->( tokyo_metro_id = nil ) {
    if tokyo_metro_id.nil?
      tokyo_metro_id = ::Operator.find_by( same_as: "odpt.Operator:TokyoMetro" ).id
    else
      unless tokyo_metro_id.integer?
        raise "Error"
      end
    end

    where( operator_id: tokyo_metro_id ).includes( :stations )
  }
  
  scope :select_branch_line , -> {
    where( is_branch_railway_line: true )
  }
  
  scope :select_not_branch_line , -> {
    where( is_branch_railway_line: [ false , nil ] )
  }

  # 東京メトロの路線を取得する
  scope :tokyo_metro , ->( including_branch_line: true ) {
    # 東京メトロの路線（支線を含む）を取得する
    if including_branch_line
      select_tokyo_metro
    # 東京メトロの路線（支線を含まない）を取得する
    else
      select_tokyo_metro.select_not_branch_line
    end
  }

  # 路線記号から路線を取得する
  scope :select_by_railway_line_codes , ->( *ary ) {
    where( name_code: ary )
  }

  # 銀座線の駅を取得する
  scope :ginza , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Ginza" )
  }
  scope :g , -> {
    ginza
  }

  # 丸ノ内線の駅を取得する
  scope :marunouchi , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" )
  }
  scope :m , -> {
    marunouchi
  }

  # 丸ノ内線（支線）の駅を取得する
  scope :marunouchi_branch , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
  }
  scope :m_branch , -> {
    marunouchi_branch
  }

  # 日比谷線の駅を取得する
  scope :hibiya , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Hibiya" )
  }
  scope :h , -> {
    hibiya
  }

  # 東西線の駅を取得する
  scope :tozai , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Tozai" )
  }
  scope :t , -> {
    tozai
  }

  # 千代田線の駅を取得する
  scope :chiyoda , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )
  }
  scope :c , -> {
    chiyoda
  }

  # 有楽町線の駅を取得する
  scope :yurakucho , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Yurakucho" )
  }
  scope :y , -> {
    yurakucho
  }

  # 半蔵門線の駅を取得する
  scope :hanzomon , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Hanzomon" )
  }
  scope :z , -> {
    hanzomon
  }

  # 南北線の駅を取得する
  scope :namboku , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Namboku" )
  }
  scope :n , -> {
    namboku
  }

  # 副都心線の駅を取得する
  scope :fukutoshin , -> {
    find_by( same_as: "odpt.Railway:TokyoMetro.Fukutoshin" )
  }
  scope :f , -> {
    fukutoshin
  }

  # 有楽町線・副都心線の駅を取得する
  scope :yurakucho_and_fukutoshin , -> {
    find_by( same_as: [ "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" ] )
  }
  scope :yf , -> {
    yurakucho_and_fukutoshin
  }

  def station_attribute_ja
    case same_as
    when "odpt.Railway:Toei.TodenArakawa"
      "停留場"
    else
      "駅"
    end
  end

  def station_attribute_hira
    case same_as
    when "odpt.Railway:Toei.TodenArakawa"
      "ていりゅうじょう"
    else
      "えき"
    end
  end

  def station_attribute_en
    "station"
  end

  def station_attribute_en_short
    "sta."
  end

  def railway_line
    self
  end

  def name_ja_with_operator_name_precise_and_without_parentheses
    name_ja_with_operator_name_precise.gsub( /（.+）\Z/ , "" )
  end
  
  def branch_railway_line_of?( railway_line )
    branch_railway_line? and railway_line.id == main_railway_line_id
  end

end