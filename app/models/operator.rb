class Operator < ActiveRecord::Base
  has_many :railway_lines
  has_many :women_only_car_infos , through: :railway_lines

  has_many :station_timetable_fundamental_infos
  has_many :station_timetable_infos , through: :station_timetable_fundamental_infos

  has_many :train_timetables

  has_many :train_operation_infos

  has_many :twitter_accounts , as: :operator_or_railway_line

  has_many :fare_normal_groups , class: ::Fare::NormalGroup , foreign_key: :operator_id

  include ::TokyoMetro::Modules::Common::Info::Operator::Info

  # 指定された鉄道事業者の id を取得する
  scope :id_of , ->( operator_same_as ) {
    find_by( same_as: operator_same_as ).id
  }
  scope :id_of_tokyo_metro , -> {
    id_of( "odpt.Operator:TokyoMetro" )
  }

  private

  def name_ja_to_a
    name_ja.split( /\// )
  end

  def name_en_to_a
    name_en.split( /\// )
  end

  def has_many_name_ja?
    /\// === name_ja
  end

  def has_many_name_en?
    /\// === name_en
  end

end
