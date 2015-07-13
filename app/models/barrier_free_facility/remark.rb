class BarrierFreeFacility::Remark < ActiveRecord::Base
  has_many :infos , class: ::BarrierFreeFacility::Info , foreign_key: :remark_id
end
