class BarrierFreeFacility::RootInfo < ActiveRecord::Base
  belongs_to :info , class: ::BarrierFreeFacility::Info
  belongs_to :place_name , class: ::BarrierFreeFacility::PlaceName
end
