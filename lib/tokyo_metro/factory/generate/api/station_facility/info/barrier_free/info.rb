# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::MetaClass

  include ::TokyoMetro::Factory::Generate::Api::MetaClass::Info::ConvertAndSetArrayData::ModuleForMethod

  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]

    place_name = @hash[ "odpt:placeName" ]
    located_area_name = @hash[ "odpt:locatedAreaName" ]
    remark = @hash[ "ugsrv:remark" ]

    unless located_area_name.string? and /\A改札(?:内|外)\Z/ === located_area_name
      located_area_name = "☆☆☆☆☆☆☆☆"
    end

    [ id , same_as , service_details , place_name , located_area_name , remark ]
  end

  private

  def to_check_validity?
    true
  end

  def check_validity(h)
    super( h , barrier_free: true )
  end

  def variables__check
    puts variables__check__separation * 32
    puts "#{variables__check__letter} called: #{ self.class.name }\#variables"
    puts " " * 3 + "service detail class:"
    puts " " * 5 + "#{self.class.name}.barrier_free_service_detail_info_class"
    puts " " * 7 + "= #{ self.class.barrier_free_service_detail_info_class.name }"
    puts ""
  end

  def variables__check__separation
    "-"
  end

  def variables__check__letter
    "○"
  end

  def service_details
    covert_and_set_array_data(
      "odpt:serviceDetail" ,
      self.class.barrier_free_service_detail_list_class ,
      self.class.barrier_free_service_detail_info_class
    )
  end

end