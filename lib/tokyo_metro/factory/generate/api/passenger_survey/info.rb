# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::PassengerSurvey::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    [ "\@id" , "owl:sameAs" , "odpt:operator" , "odpt:surveyYear" , "odpt:passengerJourneys" ].map{ | key |
      @hash[ key ]
    }
  end

end