require 'rails_helper'

RSpec.describe Station::Info, :type => :model do

  describe "Kita-Ayase" do
    kita_ayase_invalid = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Chiyoda.KitaAyase" )
    kita_ayase_valid = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )

    ids_of_kita_atase = kita_ayase_valid.station_facility_info.station_infos.pluck( :id )

    it "includes information of Kita-ayase Station on Chiyoda Branch Line" do

      expect( kita_ayase_invalid ).not_to be_present
      expect( kita_ayase_valid ).to be_present
      expect( ids_of_kita_atase ).to eq( [ kita_ayase_valid.id ] )
    end
  end

  describe "Ayase" do
    ayase_main = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Chiyoda.Ayase" )
    ayase_branch = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" )

    chiyoda_main = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )
    chiyoda_branch = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" )
    jr_joban = ::RailwayLine.find_by( same_as: "odpt.Railway:JR-East.Joban" )

    it "includes information of Ayase Station on Chiyoda Main Line" do
      expect( ayase_main ).to be_present
      expect( ayase_main.connecting_railway_line_infos.length ).to eq(2)

      connecting_railway_line_info_of_chiyoda_branch = ayase_main.connecting_railway_line_infos.find_by( railway_line_id: chiyoda_branch.id )
      connecting_railway_line_info_of_jr_joban = ayase_main.connecting_railway_line_infos.find_by( railway_line_id: jr_joban.id )

      expect( connecting_railway_line_info_of_chiyoda_branch ).to be_present
      expect( connecting_railway_line_info_of_jr_joban ).to be_present

      expect( connecting_railway_line_info_of_chiyoda_branch ).to be_hidden_on_railway_line_page
      expect( connecting_railway_line_info_of_jr_joban ).to be_hidden_on_railway_line_page
    end

    it "includes information of Ayase Station on Chiyoda Branch Line" do
      expect( ayase_branch ).to be_present
      expect( ayase_branch.connecting_railway_line_infos.length ).to eq(2)

      connecting_railway_line_info_of_chiyoda_main = ayase_branch.connecting_railway_line_infos.find_by( railway_line_id: chiyoda_main.id )
      connecting_railway_line_info_of_jr_joban = ayase_branch.connecting_railway_line_infos.find_by( railway_line_id: jr_joban.id )

      expect( connecting_railway_line_info_of_chiyoda_main ).to be_present
      expect( connecting_railway_line_info_of_jr_joban ).to be_present

      expect( connecting_railway_line_info_of_chiyoda_main ).to be_hidden_on_railway_line_page
      expect( connecting_railway_line_info_of_jr_joban ).to be_hidden_on_railway_line_page
    end
  end

end
