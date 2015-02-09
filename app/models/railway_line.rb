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

  def tokyo_metro?
    self.operator.tokyo_metro?
  end

  def not_operated_yet?
    self.same_as == "odpt.Railway:JR-East.UenoTokyo" and Time.now <= Time.new( 2015 , 3 , 14 , 3 )
  end

  # 東京メトロの路線を取得する
  scope :tokyo_metro , -> {
    operator_id_number = Operator.find_by( same_as: "odpt.Operator:TokyoMetro" ).id
    where( operator_id: operator_id_number ).where.not( same_as: [ "odpt.Railway:TokyoMetro.MarunouchiBranch" , "odpt.Railway:TokyoMetro.ChiyodaBranch" ] ).order( index: :asc )
  }

  # 東京メトロの路線（支線を含まない）を取得する
  scope :tokyo_metro_including_branch , -> {
    operator_id_number = Operator.find_by( same_as: "odpt.Operator:TokyoMetro" ).id
    where( operator_id: operator_id_number ).order( index: :asc )
  }

  # 路線記号から路線を取得する
  scope :select_by_railway_line_codes , ->( arr ) {
    where( name_code: arr )
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
end