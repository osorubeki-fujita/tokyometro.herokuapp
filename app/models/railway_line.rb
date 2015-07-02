class RailwayLine < ActiveRecord::Base

  include ::Association::To::Station::Infos

  belongs_to :operator
  has_many :station_facility_infos , through: :station_infos
  has_many :women_only_car_infos
  has_many :travel_time_infos
  has_many :railway_directions

  has_many :connecting_railway_lines
  # has_many :station_facility_infos , through: :connecting_railway_lines

  has_many :station_timetable_fundamental_infos
  has_many :station_timetables , through: :station_timetable_fundamental_infos

  has_many :train_timetables
  has_many :train_types

  has_many :train_operation_infos
  has_many :train_operation_old_infos

  has_many :train_locations
  has_many :train_location_olds

  has_many :air_conditioner_infos

  belongs_to :main_railway_line , class: ::RailwayLine
  belongs_to :branch_railway_line , class: ::RailwayLine

  has_many :twitter_accounts , as: :operator_or_railway_line

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Modules::Common::Info::RailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewAndOldRailwayLine
  include ::TokyoMetro::Modules::Db::Decision::Operator
  include ::TokyoMetro::Modules::Db::Decision::RailwayLine

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

    where( operator_id: tokyo_metro_id ).includes( :station_infos )
  }

  scope :select_branch_lines , -> {
    where( is_branch_railway_line: true )
  }

  scope :except_for_branch_lines , -> {
    where( is_branch_railway_line: [ false , nil ] )
  }

  # 東京メトロの路線を取得する
  scope :tokyo_metro , ->( including_branch_line: true ) {
    # 東京メトロの路線（支線を含む）を取得する
    if including_branch_line
      select_tokyo_metro
    # 東京メトロの路線（支線を含まない）を取得する
    else
      select_tokyo_metro.except_for_branch_lines
    end
  }

  # 路線記号から路線を取得する
  scope :select_by_railway_line_codes , ->( *ary ) {
    where( name_code: ary )
  }

  {
    ginza: :g ,
    marunouchi: :m ,
    marunouchi_branch: :m_branch ,
    hibiya: :h ,
    tozai: :t ,
    chiyoda: :c ,
    yurakucho: :y ,
    hanzomon: :z ,
    namboku: :n ,
    fukutoshin: :f
  }.each do | railway_line_basename , railway_line_code |
    eval <<-DEF
      scope :#{ railway_line_basename } , -> {
        find_by( same_as: "odpt.Railway:TokyoMetro.#{ railway_line_basename.camelize }" )
      }
      scope :#{ railway_line_code } , -> {
        #{ railway_line_basename }
      }
    DEF
  end

  # 有楽町線・副都心線を取得する
  scope :yurakucho_and_fukutoshin , -> {
    find_by( same_as: [ "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" ] )
  }
  scope :yf , -> {
    yurakucho_and_fukutoshin
  }

  # @!group 「駅」の属性（路面電車については「停留場」）

  def station_attribute_ja
    if toden_arakawa_line?
      "停留場"
    else
      "駅"
    end
  end

  def station_attribute_hira
    if toden_arakawa_line?
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

  # @!endgroup
  
  def name_ja_with_operator_name_precise_and_without_parentheses
    name_ja_with_operator_name_precise.try( :gsub , /（.+）\Z/ , "" )
  end

  # @!group Polymorphic method

  def railway_line
    self
  end

  # @todo Revision
  def except_for_branch_lines
    self
  end

  # @!group Decision

  # @param railway_line [RailwayLine] 
  def branch_railway_line_of?( railway_line )
    branch_railway_line? and railway_line.id == main_railway_line_id
  end

  def tokyo_metro?
    operator.tokyo_metro?
  end

  def jr_lines?
    same_as == "odpt.Railway:JR-East"
  end

  def toden_arakawa_line?
    same_as == "odpt.Railway:Toei.TodenArakawa"
  end

  def tobu_sky_tree_isesaki_line?
    same_as == "odpt.Railway:Tobu.SkyTreeIsesaki"
  end

  def seibu_yurakucho_line?
    same_as == "odpt.Railway:Seibu.SeibuYurakucho"
  end

  # @!endgroup

  class ActiveRecord_Relation

    def to_main_lines
      main_ids_from_branch = select_branch_lines.map( &:main_railway_line_id ).uniq
      main_ids = except_for_branch_lines.map( &:id ).uniq
      railway_line_ids = [ main_ids_from_branch , main_ids ].flatten.uniq.sort
      return ::RailwayLine.where( id: railway_line_ids )
    end

  end

end
