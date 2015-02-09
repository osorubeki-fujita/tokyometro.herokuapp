# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Generate::Api::TrainInformation::Info < TokyoMetro::Factories::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::TrainInformation

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    dc_date = DateTime.parse( @hash[ "dc:date" ] )
    valid = DateTime.parse( @hash[ "dct:valid" ] )

    operator = @hash[ "odpt:operator" ]

    time_of_origin = DateTime.parse( @hash[ "odpt:timeOfOrigin" ] )

    railway_line = @hash[ "odpt:railway" ]
    train_information_status = @hash[ "odpt:trainInformationStatus" ]
    train_information_text = @hash[ "odpt:trainInformationText" ]

    [ id , dc_date , valid , operator , time_of_origin , railway_line , train_information_status , train_information_text ]
  end

end