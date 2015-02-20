class StationFacilityPlatformInfoTransferInfo < ActiveRecord::Base
  belongs_to :station_facility_platform_info
  belongs_to :railway_line
  belongs_to :railway_direction

  def to_array_of_displayed_infos
    [ railway_line_id , railway_direction_id , necessary_time ]
  end

end