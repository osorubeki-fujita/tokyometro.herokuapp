require 'rails_helper'

RSpec.describe StationFacility::Info , :type => :model do
  invalid_railway_direction_of_platform_transfer_info_at_kudanshita = "odpt.Railway:Toei.Shinjuku"
  describe "after converting invalid railway direction in platform transfer info at Kudanshita" do
    it "does not have invalid railway direction \'#{ invalid_railway_direction_of_platform_transfer_info_at_kudanshita }\'." do

      toei_shinjuku_line = ::RailwayLine.find_by( same_as: "odpt.Railway:Toei.Shinjuku" )
      kudanshita = ::StationFacility::Info.find_by( "odpt.StationFacility:TokyoMetro.Kudanshita" )

      toei_shinjuku_line_for_motoyawata = ::RailwayDirection.find_by( same_as: "odpt.RailwayDirection:Toei.Shinjuku.Motoyawata" )
      toei_shinjuku_line_for_shinjuku = ::RailwayDirection.find_by( same_as: "odpt.RailwayDirection:Toei.Shinjuku.Shinjuku" )

      expect( toei_shinjuku_line ).to be_present
      expect( kudanshita ).to be_present

      p_infos = kudanshita.platform_infos
      expect( p_infos ).to be_present

      p_infos.each do | platform_info |
        t_infos = platform_info.transfer_infos
        if t_infos.present?

          t_infos.each do | transfer_info |
            if transfer_info.railway_line_id == toei_shinjuku_line.id
              expect( [ nil , toei_shinjuku_line_for_motoyawata.id , toei_shinjuku_line_for_shinjuku.id ] ).to include( transfer_info.railway_direction_id )
            end
          end

        end
      end

    end
  end
end
