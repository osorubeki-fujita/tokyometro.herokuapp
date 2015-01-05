# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::Fare < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::Fare

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    date = DateTime.parse( @hash[ "dc:date" ] )
    operator = @hash[ "odpt:operator" ]
    from_station = @hash[ "odpt:fromStation" ]
    to_station = @hash[ "odpt:toStation" ]

    fares = [ "odpt:ticketFare" , "odpt:childTicketFare" , "odpt:icCardFare" , "odpt:childIcCardFare" ].map { | key | @hash[ key ] }
    normal_fare = ::TokyoMetro::StaticDatas.normal_fare.select_fare( *fares )

    [ id , same_as , date , operator , from_station , to_station , normal_fare ]
  end

end