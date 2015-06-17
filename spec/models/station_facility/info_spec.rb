require 'rails_helper'

RSpec.describe StationFacility::Info , :type => :model do

  invalid_railway_direction_of_platform_transfer_info_at_kudanshita = "odpt.Railway:Toei.Shinjuku"

  describe "after converting invalid railway direction in platform transfer info at Kudanshita" do
    it "does not have invalid railway direction \'#{ invalid_railway_direction_of_platform_transfer_info_at_kudanshita }\'." do

      kudanshita = ::StationFacility::Info.find_by( same_as: "odpt.StationFacility:TokyoMetro.Kudanshita" )
      toei_shinjuku_line = ::RailwayLine.find_by( same_as: "odpt.Railway:Toei.Shinjuku" )

      expect( kudanshita ).to be_present
      expect( toei_shinjuku_line ).to be_present

      toei_shinjuku_line_for_motoyawata = ::RailwayDirection.find_by( same_as: "odpt.RailwayDirection:Toei.Shinjuku.Motoyawata" )
      toei_shinjuku_line_for_shinjuku = ::RailwayDirection.find_by( same_as: "odpt.RailwayDirection:Toei.Shinjuku.Shinjuku" )

      expect( toei_shinjuku_line_for_motoyawata ).to be_present
      expect( toei_shinjuku_line_for_shinjuku ).to be_present

      p_infos = kudanshita.platform_infos
      expect( p_infos ).to be_present

      p_infos.each do | platform_info |
        t_infos = platform_info.transfer_infos
        if t_infos.present?

          t_infos.each do | transfer_info |
            if transfer_info.railway_line_id == toei_shinjuku_line.id
              if transfer_info.railway_direction_id == 0
                # transfer_info.update( railway_direction_id: nil )
              end
              expect( [ nil , 0 , toei_shinjuku_line_for_motoyawata.id , toei_shinjuku_line_for_shinjuku.id ] ).to include( transfer_info.railway_direction_id )
            end
          end

        end
      end

    end
  end

  describe "after converting railway line and railway direction in platform transfer info at Nakano-sakaue" do
    it "has platform transfer info from Marunouchi Line to Marunouchi Branch Line for Honancho." do
      nakano_sakaue = ::StationFacility::Info.find_by( same_as: "odpt.StationFacility:TokyoMetro.NakanoSakaue" )

      expect( nakano_sakaue ).to be_present

      railway_lines = {
        main: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" ) ,
        branch: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
      }
      oedo_line = ::RailwayLine.find_by( same_as: "odpt.Railway:Toei.Oedo" )

      railway_lines.values.each do |v|
        expect( v ).to be_present
      end
      expect( oedo_line ).to be_present

      p_infos = nakano_sakaue.platform_infos
      expect( p_infos ).to be_present

      for_honancho_in_api_same_as = "odpt.RailDirection:TokyoMetro.Honancho"
      for_honancho_on_branch_line = ::RailwayDirection.find_by( railway_line_id: railway_lines[ :branch ].id , in_api_same_as: for_honancho_in_api_same_as )
      expect( for_honancho_on_branch_line ).to be_present

      p_infos.each do | platform_info |
        if platform_info.railway_line_id == railway_lines[ :main ].id and platform_info.car_composition == 6
          t_infos = platform_info.transfer_infos
          if t_infos.present?

            t_infos.each do | transfer_info |
              if transfer_info.railway_line_id != oedo_line.id and transfer_info.railway_direction.try( :in_api_same_as ) == for_honancho_in_api_same_as
                expect( transfer_info.railway_line_id ).to eq( railway_lines[ :branch ].id )
                expect( transfer_info.railway_direction_id ).to eq( for_honancho_on_branch_line.id )
              end
            end

          end
        end
      end

    end
  end

end
