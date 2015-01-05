# トイレの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  # Constructor
  def initialize( id_urn , same_as , service_detail , place_name , located_area_name , remark , has_assistant )
    super( id_urn , same_as , service_detail , place_name , located_area_name , remark )
    @has_assistant = has_assistant
  end

  def seed_additional_info( facility_id )
    super
    if self.assistant_facility.present?
      self.assistant_facility.seed( facility_id )
    end
  end

  # トイレ内のバリアフリー設備
  # @return [Assistant or nil]
  attr_reader :has_assistant
  alias :assistant_facility :has_assistant

  # @!group バリアフリー設備に関するメソッド

  # トイレ内にバリアフリー設備があるか否かを判定するメソッド
  # @return [Boolean]
  def assistant_facility_available?
    self.assistant_facility.instance_of?( self.class.assinstant_class )
  end

  # @!endgroup

end