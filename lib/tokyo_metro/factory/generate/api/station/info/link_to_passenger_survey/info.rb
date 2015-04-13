# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::Station::Info::LinkToPassengerSurvey::Info < TokyoMetro::Factory::Generate::Api::Station::Info::Common::Info

  private

  def self.instance_class
    link_to_passenger_survey_info_class
  end

end