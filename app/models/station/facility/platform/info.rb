class Station::Facility::Platform::Info < ActiveRecord::Base

  belongs_to :station_facility_info , class: ::Station::Facility::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :railway_direction , class: ::Railway::Direction

  has_many :platform_barrier_free_facility_infos , class: ::Station::Facility::Platform::BarrierFreeFacilityInfo , foreign_key: :platform_info_id
  has_many :platform_transfer_infos , class: ::Station::Facility::Platform::TransferInfo , foreign_key: :platform_info_id
  has_many :platform_surrounding_areas , class: ::Station::Facility::Platform::SurroundingArea , foreign_key: :platform_info_id

  has_many :barrier_free_facility_infos , through: :platform_barrier_free_facility_infos , class: ::BarrierFreeFacility::Info
  has_many :surrounding_areas , through: :platform_surrounding_areas

end
