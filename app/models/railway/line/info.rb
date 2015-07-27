class Railway::Line::Info < ActiveRecord::Base

  default_scope {
    order( operator_info_id: :asc ).order( index_in_operator: :asc )
  }

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

  #-------- 支線
  has_many :relation_infos_as_main_railway_line , class: ::Railway::Line::Relation , foreign_key: :main_railway_line_info_id
  has_many :relation_infos_as_branch_railway_line , class: ::Railway::Line::Relation , foreign_key: :branch_railway_line_info_id

  has_many :main_railway_line_infos , class: ::Railway::Line::Info , through: :relation_infos_as_branch_railway_line
  has_many :branch_railway_line_infos , class: ::Railway::Line::Info , through: :relation_infos_as_main_railway_line

  #-------- Twitter
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
  include ::OdptCommon::Modules::Attributes::Common::RailwayLine::Station
  include ::OdptCommon::Modules::Attributes::Common::RailwayLine::Branch
  include ::TokyoMetro::Modules::Name::Common::RailwayLine::CssClass
  include ::TokyoMetro::Modules::Decision::Common::RailwayLine::NewAndOld

  include ::OdptCommon::Modules::MethodMissing::Decision::Common::RailwayLine::BranchLine


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
    branch_ids = ::Railway::Line::Relation.all.pluck( :branch_railway_line_info_id )
    where( id: branch_ids )
  }

  scope :except_for_branch_lines , -> {
    branch_ids = ::Railway::Line::Relation.all.pluck( :branch_railway_line_info_id )
    where.not( id: branch_ids )
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

  # @todo Revision - Container などを使用
  def except_for_branch_lines
    self
  end

  # @!group Branch railway line infos

  # @param railway_line [Railway::Line::Info]
  def branch_railway_line_info_of?( _railway_line_info )
    is_branch_railway_line_info? and ids_of_upper_railway_line_infos.include?( _railway_line_info.id )
  end

  [
    :is_branch_railway_line_info? , :has_branch_railway_line_infos? ,
    :ids_of_top_main_railway_line_infos , :ids_of_upper_railway_line_infos , :ids_of_branch_railway_line_infos
  ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        ::OdptCommon::App::Container::Railway::Line::Info.new( self ).send( __method__ )
      end
    DEF
  end

  # @!endgroup

  class ActiveRecord_Relation

    def to_main_railway_lines
      ary = to_a
      ids_of_main_railway_lines = ary.map( &:ids_of_top_main_railway_line_infos ).flatten.sort.uniq
      return ::Railway::Line::Info.where( id: ids_of_main_railway_lines )
    end

  end

end
