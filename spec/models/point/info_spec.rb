require 'rails_helper'

RSpec.describe Point::Info, type: :model do
  ginza = ::StationFacility::Info.find_by( same_as: "odpt.StationFacility:TokyoMetro.Ginza" )
  kanda = ::StationFacility::Info.find_by( same_as: "odpt.StationFacility:TokyoMetro.Kanda" )

  point_infos_in_ginza = ginza.point_infos
  point_infos_in_kanda = kanda.point_infos

  common_point_info_ids = ( point_infos_in_ginza.pluck( :id ) & point_infos_in_kanda.pluck( :id ) )

  it "has invalid info of point info." do
    expect( common_point_info_ids ).to be_blank
  end

end
