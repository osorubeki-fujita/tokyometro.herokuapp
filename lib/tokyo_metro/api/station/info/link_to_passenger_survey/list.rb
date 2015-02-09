# 駅乗降人員数を表すオブジェクトへのリンクの配列
class TokyoMetro::Api::Station::Info::LinkToPassengerSurvey::List < TokyoMetro::Api::Station::Info::Common::List

  def self.factory_for_seeding_this_class
    factory_for_seeding_link_to_passenger_surveys_of_each_station
  end

end