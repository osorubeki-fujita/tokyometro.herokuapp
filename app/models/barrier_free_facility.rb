class BarrierFreeFacility < ActiveRecord::Base

  belongs_to :station_facility
  belongs_to :barrier_free_facility_type
  belongs_to :barrier_free_facility_located_area

  has_many :barrier_free_facility_root_infos
  has_many :barrier_free_facility_place_names , through: :barrier_free_facility_root_infos

  has_many :barrier_free_facility_service_details
  has_many :barrier_free_facility_service_detail_patterns , through: :barrier_free_facility_service_details
  has_many :barrier_free_facility_escalator_directions , through: :barrier_free_facility_service_details

  has_many :barrier_free_facility_toilet_assistants # 実際の個数は0または1
  has_many :barrier_free_facility_toilet_assistant_patterns , through: :barrier_free_facility_toilet_assistants

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::LocatedArea

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::Availability::AliasTowardsAccessibility
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::MethodMissing

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::Availability::Escalator

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::MobilityScooter::Availability::None
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::MobilityScooter::Availability::AliasTowardsAccessibility
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::MobilityScooter::MethodMissing

  ::TokyoMetro::CommonModules::Dictionary::BarrierFree.facility_types.each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }?
        barrier_free_facility_type.send( __method__ )
      end
    DEF
  end

  def root_infos
    barrier_free_facility_root_infos.includes( :barrier_free_facility_place_name )
  end

  [
    :type , :located_area , :place_names ,
    :service_details , :service_detail_patterns , :escalator_directions ,
    :toilet_assistants , :toilet_assistant_patterns
  ].each do | method_name |
    eval <<-DEF
      def #{method_name}
        barrier_free_facility_#{method_name}
      end
    DEF
  end

  def toilet_assistant_info
    _toilet_assistant_patterns = toilet_assistant_patterns
    if _toilet_assistant_patterns.present?
      unless _toilet_assistant_patterns.length == 1
        raise "Error"
      end
      _toilet_assistant_patterns.first
    else
      nil
    end
  end

  def remark_to_a
    self.remark.gsub( /。([\(（].+?[\)）])/ ) { "#{$1}。" }.gsub( /(?<=。)\n?[ 　]?/ , "\n" ).gsub( "出きません" , "できません" ).split( /\n/ )
  end
  
  [ :name_ja , :name_en ].each do | method_base_name |
    eval <<-DEF
      def located_area_#{ method_base_name }
        located_area.#{ method_base_name }
      end
    DEF
  end

  # 個々の駅施設の記号を返すメソッド
  # @return [Hash]
  def id_and_code_hash
    regexp = /\Aodpt\.StationFacility\:TokyoMetro\.(\w+)\.(?:\w+)\.(Inside|Outside)\.(\w+)/
    if regexp =~ self.same_as.to_s
      railway_line_name = $1

      case railway_line_name
      when "Hanzomon"
        railway_line_code = "Z"
      else
        railway_line_code = railway_line_name.first
      end
      place = $2
      category = $3
      if /\A\.(\d+)\Z/ =~ self.same_as.to_s.gsub( regexp , "" )
        number = $1
      else
        number = nil
      end
    else
      raise "Error: " + self.same_as
    end

    facility_id = [ place.downcase , category.downcase , number.to_s ].select { | item | item.present? }.join( "_" )
    facility_code = railway_line_code + number.to_s
    platform = [ place , category , number.to_s ].select { | item | item.present? }.join( "." )
    { :id => facility_id , :code => facility_code , :platform => platform }
  end

end