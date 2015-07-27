class Railway::Line::Info < ActiveRecord::Base

  has_many :station_infos , class: ::Station::Info , foreign_key: :railway_line_info_id

  belongs_to :operator_info , class: ::Operator::Info

  has_many :station_facility_infos , through: :station_infos
  has_many :women_only_car_infos , class: ::Railway::Line::WomenOnlyCarInfo , foreign_key: :railway_line_info_id
  has_many :travel_time_infos , class: ::Railway::Line::TravelTimeInfo , foreign_key: :railway_line_info_id
  has_many :railway_directions

  has_many :connecting_railway_line_infos , class: ::ConnectingRailwayLine::Info , foreign_key: :railway_line_info_id

  has_many :station_timetable_fundamental_infos
  has_many :station_timetable_infos , through: :station_timetable_fundamental_infos

  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :railway_line_info_id
  has_many :train_type_infos , class: ::Train::Type::Info , foreign_key: :railway_line_info_id

  has_many :train_timetable_train_type_in_other_operator_infos , class: ::Train::Timetable::TrainTypeInOtherOperatorInfo , foreign_key: :railway_line_info_id

  has_many :train_type_stopping_patterns , class: ::Train::Type::StoppingPattern , foreign_key: :railway_line_info_id

  has_many :train_operation_infos , class: ::Train::Operation::Info , foreign_key: :railway_line_info_id
  has_many :train_location_infos , class: ::Train::Location::Info , foreign_key: :railway_line_info_id

  has_many :air_conditioner_infos

  belongs_to :main_railway_line_info , class: ::Railway::Line::Info
  belongs_to :branch_railway_line_info , class: ::Railway::Line::Info

  has_many :twitter_accounts , as: :operator_info_or_railway_line_info

  #-------- 補足情報
  has_many :additional_infos , class: ::Railway::Line::AdditionalInfo , foreign_key: :info_id

    #-------- 路線コード
  has_many :info_code_infos , class: ::Railway::Line::InfoCodeInfo , foreign_key: :info_id
  has_many :code_infos , class: ::Railway::Line::CodeInfo , through: :info_code_infos

  include ::OdptCommon::Modules::Polymorphic::RailwayLine
  include ::OdptCommon::Modules::Decision::Common::RailwayLine::Name

  include ::OdptCommon::Modules::Name::Common::Fundamental::GetMainName
  include ::OdptCommon::Modules::Name::Db::GetList

  include ::TokyoMetro::Modules::Decision::Common::Fundamental::CompareBase
  include ::TokyoMetro::Modules::Decision::Common::RailwayLine::Name
  include ::TokyoMetro::Modules::Decision::Db::Operator::Name

  include ::OdptCommon::Modules::Name::Common::RailwayLine::Info
  include ::OdptCommon::Modules::Name::Common::RailwayLine::StationAttribute
  include ::TokyoMetro::Modules::Name::Common::RailwayLine::CssClass
  include ::TokyoMetro::Modules::Decision::Common::RailwayLine::NewAndOld

  include ::OdptCommon::Modules::MethodMissing::Decision::Common::RailwayLine::BranchLine

  default_scope {
    order( operator_info_id: :asc ).order( index_in_operator: :asc )
  }

  scope :select_tokyo_metro , ->( tokyo_metro_id = nil ) {
    if tokyo_metro_id.nil?
      tokyo_metro_id = ::Operator::Info.find_by( same_as: "odpt.Operator:TokyoMetro" ).id
    else
      unless tokyo_metro_id.integer?
        raise "Error"
      end
    end

    where( operator_info_id: tokyo_metro_id ).includes( :station_infos )
  }

  scope :select_branch_lines , -> {
    where( is_branch_railway_line_info: true )
  }

  scope :except_for_branch_lines , -> {
    where( is_branch_railway_line_info: [ false , nil ] )
  }

  scope :defined , -> {
    where.not( same_as: "odpt.Railway:Undefined" )
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
    where( code: ary )
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

  # @!group 基礎情報の配列

  def name_ja_to_a
    get_list( name_ja )
  end

  def name_en_to_a
    get_list( name_en )
  end

  def codes_to_a
    code_infos.pluck( :code ).delete_if( &:blank? )
  end

  def colors_to_a
    code_infos.pluck( :color ).delete_if( &:blank? )
  end

  def color_normal
    colors_to_a.first
  end

  # @!group Decision

  # @param railway_line [Railway::Line::Info]
  def branch_railway_line_info_of?( _railway_line_info )
    branch_railway_line_info? and _railway_line_info.id == main_railway_line_info_id
  end

  # @todo Revision - Container などを使用
  def except_for_branch_lines
    self
  end

  # @!endgroup

  class ActiveRecord_Relation

    def to_main_lines
      main_ids_from_branch = select_branch_lines.map( &:main_railway_line_info_id ).uniq
      main_ids = except_for_branch_lines.map( &:id ).uniq
      railway_line_info_ids = [ main_ids_from_branch , main_ids ].flatten.uniq.sort
      return ::Railway::Line::Info.where( id: railway_line_info_ids )
    end

  end

end
