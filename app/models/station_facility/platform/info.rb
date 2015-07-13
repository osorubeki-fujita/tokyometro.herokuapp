class StationFacility::Platform::Info < ActiveRecord::Base

  belongs_to :station_facility_info , class: ::StationFacility::Info
  belongs_to :railway_line
  belongs_to :railway_direction

  has_many :platform_barrier_free_facility_infos , class: ::StationFacility::Platform::BarrierFreeFacilityInfo , foreign_key: :platform_info_id
  has_many :platform_transfer_infos , class: ::StationFacility::Platform::TransferInfo , foreign_key: :platform_info_id
  has_many :platform_surrounding_areas , class: ::StationFacility::Platform::SurroundingArea , foreign_key: :platform_info_id

  has_many :barrier_free_facility_infos , through: :platform_barrier_free_facility_infos , class: ::BarrierFreeFacility::Info
  has_many :surrounding_areas , through: :platform_surrounding_areas
end
