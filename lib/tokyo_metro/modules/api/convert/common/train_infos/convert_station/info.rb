# @note {::TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStation#.set_modules} により、{::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info}, {::TokyoMetro::Api::TrainTimetable::Info} へ include される。
module TokyoMetro::Modules::Api::Convert::Common::TrainInfos::ConvertStation::Info

  private

  def convert_station( station , invalid , valid )
    if station == invalid
      valid
    else
      station
    end
  end

end