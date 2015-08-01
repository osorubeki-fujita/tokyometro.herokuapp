class Operator::Info < ActiveRecord::Base

  has_many :railway_line_infos , class: ::Railway::Line::Info , foreign_key: :operator_info_id
  has_many :women_only_car_infos , class: ::Railway::Line::WomenOnlyCarInfo , through: :railway_line_infos

  has_many :station_timetable_fundamental_infos , class: ::Station::Timetable::FundamentalInfo , foreign_key: :operator_info_id
  has_many :station_timetable_infos , class: ::Station::Timetable::Info , through: :station_timetable_fundamental_infos

  has_many :train_timetable_infos , class: ::Train::Timetable::Info , foreign_key: :operator_info_id

  has_many :train_operation_infos , class: ::Train::Operation::Info , foreign_key: :operator_info_id

  has_many :fare_normal_groups , class: ::Fare::NormalGroup , foreign_key: :operator_info_id

  has_many :twitter_accounts , class: ::TwitterAccount , as: :operator_info_or_railway_line_info , foreign_key: :operator_info_or_railway_line_info_id

  has_many :operator_as_train_owners , class: ::Operator::AsTrainOwner , foreign_key: :info_id

  has_one :code_info , class: ::Operator::CodeInfo , foreign_key: :info_id

  include ::OdptCommon::Modules::Polymorphic::Operator

  include ::OdptCommon::Modules::Name::Db::GetList

  include ::OdptCommon::Modules::Name::Common::Operator::Info
  include ::TokyoMetro::Modules::Name::Common::Operator::CssClass

  include ::TokyoMetro::Modules::Decision::Common::Fundamental::CompareBase
  include ::TokyoMetro::Modules::Decision::Db::Operator::Name

  # 指定された鉄道事業者の id を取得する
  scope :id_of , ->( operator_same_as ) {
    find_by( same_as: operator_same_as ).id
  }
  scope :id_of_tokyo_metro , -> {
    id_of( "odpt.Operator:TokyoMetro" )
  }

  scope :defined , -> {
    where.not( same_as: "odpt.Operator:Undefined" )
  }

  def color
    color_info.hex_color
  end

  alias :color_normal :color

  private

  [ :ja , :hira , :en ].each do | name_attr |
    eval <<-DEF
      def name_#{ name_attr }_to_a
        get_list( name_#{ name_attr } )
      end
    DEF
  end

  def color_info
    code_info.color_info
  end

end
