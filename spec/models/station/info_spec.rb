require 'rails_helper'

RSpec.describe Station::Info, :type => :model do

  describe "Nakano-sakaue" do
    station_infos = {
      main: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue" ) ,
      branch: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue" )
    }
    railway_lines = {
      main: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" ) ,
      branch: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
    }

    station_infos.each do | k , station_info |
      c = station_info.connecting_railway_line_infos
      oedo = ::RailwayLine.find_by( same_as: "odpt.Railway:Toei.Oedo" )

      it "has station info on #{k} line." do
        expect( station_info ).to be_present
      end

      it "(info on #{k} line) has two connecting railway line infos." do
        expect( c ).to be_present
        expect( c.length ).to eq(2)
      end

      it "has connecting railway line info to Toei Oedo Line" do
        c_to_oedo = c.find_by( railway_line_id: oedo.id )
        expect( c_to_oedo ).to be_present
        expect( c_to_oedo.index_in_station ).to eq(2)
      end

      case k
      when :main
        another_railway_line_key = :branch
      when :branch
        another_railway_line_key = :main
      end
      another_railway_line = railway_lines[ another_railway_line_key ]

      it "has connecting railway line info to Marunouchi #{ another_railway_line_key.capitalize } Line." do
        c_to_another = c.find_by( railway_line_id: another_railway_line.id )
        expect( c_to_another ).to be_present
        expect( c_to_another.index_in_station ).to eq(1)
      end
    end

  end

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
