class BarrierFreeFacility < ActiveRecord::Base
  belongs_to :station_facility
  belongs_to :barrier_free_facility_type
  belongs_to :barrier_free_facility_located_area

  has_many :barrier_free_facility_root_infos
  has_many :barrier_free_facility_place_names , through: :barrier_free_facility_root_infos

  has_many :barrier_free_facility_service_details
  has_many :barrier_free_facility_service_detail_patterns , through: :barrier_free_facility_service_details

  has_many :barrier_free_facility_toilet_assistants # 実際の個数は0または1
  has_many :barrier_free_facility_toilet_assistant_patterns , through: :barrier_free_facility_toilet_assistants

  def facility_type
    self.barrier_free_facility_type
  end

  def toilet?
    self.facility_type.name_en == "Toilet"
  end

  def root_infos
    self.barrier_free_facility_root_infos.includes( :barrier_free_facility_place_name )
  end

  def remark_formatted
    self.remark.gsub( /。\n?/ , "。\n" ).split( /\n/ )
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