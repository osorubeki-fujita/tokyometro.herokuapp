class StationFacility < ActiveRecord::Base
  has_many :stations
  # has_many :railway_lines , through: :stations

  has_many :passenger_surveys , through: :stations

  has_many :station_facility_platform_infos
  has_many :surrounding_areas , through: :station_facility_platform_infos

  has_many :connecting_railway_lines , through: :stations
  has_many :railway_lines , through: :connecting_railway_lines
  has_many :operators , through: :railway_lines

  has_many :station_facility_aliases

  has_many :barrier_free_facilities
  has_many :points

  def platform_infos
    station_facility_platform_infos
  end

  def platform_infos_including_other_infos
    platform_infos.includes(
      :railway_line ,
      :railway_direction ,
      :station_facility_platform_info_barrier_free_facilities ,
      :station_facility_platform_info_transfer_infos ,
      :station_facility_platform_info_surrounding_areas ,
      :barrier_free_facilities ,
      :surrounding_areas
    )
  end

  def platform_infos_including_other_infos_grouped_by_railway_line_id
    platform_infos_including_other_infos.group_by( &:railway_line_id )
  end

end