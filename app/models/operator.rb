class Operator < ActiveRecord::Base

  has_many :railway_line_infos , class: ::Railway::Line::Info
  has_many :women_only_car_infos , through: :railway_line_infos, class: ::Railway::Line::WomenOnlyCarInfo

  has_many :station_timetable_fundamental_infos
  has_many :station_timetable_infos , through: :station_timetable_fundamental_infos

  has_many :train_timetables

  has_many :train_operation_infos

  has_many :twitter_accounts , as: :operator_or_railway_line_info

  has_many :fare_normal_groups , class: ::Fare::NormalGroup , foreign_key: :operator_id

  include ::OdptCommon::Modules::Name::Db::GetList

  include ::OdptCommon::Modules::Name::Common::Operator
  include ::TokyoMetro::Modules::Name::Common::Operator::CssClass

  include ::TokyoMetro::Modules::Decision::Common::Fundamental::CompareBase
  include ::TokyoMetro::Modules::Decision::Db::Operator

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

  private

  def operator
    self
  end

  def name_ja_to_a
    get_list( name_ja )
  end

  def name_en_to_a
    get_list( name_en )
  end

end
