class BarrierFreeFacility::PlaceName < ActiveRecord::Base
  has_many :root_infos , class: ::BarrierFreeFacility::RootInfo , foreign_key: :place_name_id
  has_many :infos , through: :root_infos , class: ::BarrierFreeFacility::Info
end
