# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::NotOnTheTopLayer

  include ::TokyoMetro::ApiModules::ToFactoryClass::ConvertAndSetArrayData
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]

    place_name = @hash[ "odpt:placeName" ]
    located_area_name = @hash[ "odpt:locatedAreaName" ]
    remark = @hash[ "ugsrv:remark" ]

    unless located_area_name.string? and /\A改札(?:内|外)\Z/ === located_area_name
      located_area_name = "☆☆☆☆☆☆☆☆"
    end

    [ id , same_as , service_detail , place_name , located_area_name , remark ]
  end

  private

  def variables__check
    puts variables__check__separation * 32
    puts "#{variables__check__letter} called: #{ self.class.name }\#variables"
    puts " " * 3 + "service detail class:"
    puts " " * 5 + "#{self.class.name}.service_detail_class"
    puts " " * 7 + "= #{ self.class.service_detail_class.name }"
    puts ""
  end

  def variables__check__separation
    "-"
  end

  def variables__check__letter
    "○"
  end

  def service_detail
    covert_and_set_array_data( "odpt:serviceDetail" ,
      self.class.service_detail_list_class , self.class.service_detail_class ,
      generate_info_instance: true )
  end

end