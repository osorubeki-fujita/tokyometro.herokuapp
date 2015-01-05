# 各社・各種別に共通するメタクラス
class TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::YurakuchoFukusohin::TrainType::Fundamental

  # Constructor
  def initialize( border , line , train_type , train_type_in_db )
    @border = border
    @line = line
    @train_type = train_type
    @train_type_in_db = train_type_in_db
  end

  attr_reader :border
  attr_reader :line
  attr_reader :train_type
  attr_reader :train_type_in_db

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s
    "#{@border.to_s}から先、#{@line.to_s}線内は#{@train_type.to_s}として運行します。"
  end

  def seed_and_get_id
    station_instance = ::Station.find_by( name_ja: @border , railway_line_id: railway_line_instance_on_the_border_station_in_db.id )
    train_type_instance = ::TrainType.find_by_same_as( @train_type_in_db )

    train_type_in_other_operator_h = {
      railway_line_id: railway_line_instance_in_db.id ,
      from_station_id: station_instance.id ,
      train_type_id: train_type_instance.id ,
      note: self.to_s
    }
    ::TimetableTrainTypeInOtherOperator.find_or_create_by( train_type_in_other_operator_h ).id
  end

end