# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::Platform::Info < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer

  def variables
    # puts "TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::Platform::Info\#variables"

    ary_1 = [ "odpt:railway" , "odpt:carComposition" , "odpt:carNumber" , "odpt:railDirection" ].map { | key | @hash[ key ] }

    barrierfree_facility = @hash[ "odpt:barrierfreeFacility" ]
    surrounding_area = @hash[ "odpt:surroundingArea" ]

    ary_1 + [ transfer_information , barrierfree_facility , surrounding_area ]
  end

  def self.instance_class
    ::TokyoMetro::Api::StationFacility::Info::Platform::Info
  end

  def self.transfer_info_class
    ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer
  end

  private

  def transfer_information
    info = @hash[ "odpt:transferInformation" ]
    if info.instance_of?( ::Array )
      info_class = self.class.transfer_info_class
      list_class = info_class::List
      unless list_class == ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer::List
        raise "Error: #{list_class.name} is not valid."
      end

      ary_new = list_class.new
      info.each do | info |
        ary_new << info_class.generate_from_hash( info )
      end
      unless list_class == ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer::List
        raise "Error: #{list_class.name} is not valid."
      end
      ary_new
    else
      nil
    end
  end

end