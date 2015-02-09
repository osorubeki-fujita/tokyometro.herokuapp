# トイレの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  # Constructor
  def initialize( id_urn , same_as , service_detail , place_name , located_area_name , remark , has_assistant )
    super( id_urn , same_as , service_detail , place_name , located_area_name , remark )
    @has_assistant = has_assistant
  end

  # トイレ内のバリアフリー設備
  # @return [Assistant or nil]
  attr_reader :has_assistant
  alias :assistant_facility :has_assistant

  # @!group バリアフリー設備に関するメソッド

  # トイレ内にバリアフリー設備があるか否かを判定するメソッド
  # @return [Boolean]
  def assistant_facility_available?
    self.assistant_facility.instance_of?( self.class.barrier_free_toilet_assinstant_class )
  end

  def self.factory_for_this_class
    factory_for_generating_barrier_free_toilet_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facility_toilet_info
  end

  # @!endgroup

end