module TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStartingStation::Info

  private

  # @note {::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStation::Info#convert_station} を用いる。
  # @note このモジュール {::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStartingStation::Info} と {::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStation::Info} はいずれも {::TokyoMetro::Api::TrainTimetable::Info}に include される。
  def convert_starting_station( invalid , valid )
    @starting_station = convert_station( @starting_station , invalid , valid )
  end

end