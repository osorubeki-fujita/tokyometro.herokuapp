class Operator < ActiveRecord::Base
  has_many :railway_lines
  has_many :women_only_car_infos , through: :railway_lines

  has_many :station_timetable_fundamental_infos
  has_many :station_timetables , through: :station_timetable_fundamental_infos

  has_many :train_timetables

  has_many :train_operation_infos
  has_many :train_operation_old_infos

  has_many :twitter_accounts , as: :operator_or_railway_line

  include ::TokyoMetro::Modules::Common::Info::Operator

  # 指定された鉄道事業者の id を取得する
  scope :id_of , ->( operator_same_as ) {
    find_by( same_as: operator_same_as ).id
  }
  scope :id_of_tokyo_metro , -> {
    id_of( "odpt.Operator:TokyoMetro" )
  }
  
  def name_ja_normal
    name_ja.split( "/" ).first
  end
  
  def name_en_normal
    name_en.split( "/" ).first
  end

end
