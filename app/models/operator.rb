class Operator < ActiveRecord::Base
  has_many :railway_lines
  has_many :women_only_car_infos , through: :railway_lines
  has_many :timetables
  has_many :train_timetables

  has_many :train_informations
  has_many :train_information_olds

  # 指定された鉄道事業者の id を取得する
  scope :id_of_operator , ->( operator_same_as ) {
    find_by( same_as: operator_same_as ).id
  }
  scope :id_of_tokyo_metro , -> {
    id_of_operator( "odpt.Operator:TokyoMetro" )
  }

  def tokyo_metro?
    self.same_as == "odpt.Operator:TokyoMetro"
  end

end