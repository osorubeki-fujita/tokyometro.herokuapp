# 各社・各種別に共通するメタクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::Fundamental

  # Constructor
  def initialize( border , railway_line , train_type , train_type_in_db )
    @border = border
    @railway_line = railway_line
    @train_type = train_type
    @train_type_in_db = train_type_in_db
  end

  attr_reader :border
  attr_reader :railway_line
  attr_reader :train_type
  attr_reader :train_type_in_db

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s
    "#{@border.to_s}から先、#{@railway_line.to_s}線内は#{@train_type.to_s}として運行します。"
  end

  def seed_and_get_id
    station_in_db = ::Station.find_by( name_ja: @border , railway_line_id: railway_line_on_the_border_station_in_db.id )
    train_type_instance = ::TrainType.find_by_same_as( @train_type_in_db )

    h = {
      railway_line_id: railway_line_in_db.id ,
      from_station_id: station_in_db.id ,
      train_type_id: train_type_instance.id ,
      note: self.to_s
    }
    ::TrainTimetableTrainTypeInOtherOperator.find_or_create_by(h).id
  end

end