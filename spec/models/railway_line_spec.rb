require 'rails_helper'

RSpec.describe RailwayLine, :type => :model do

  describe "As for Kita-ayase" do
    chiyoda_branch = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" )
    chiyoda = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )

    kita_ayase_valid = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )
    station_infos_related_to_kita_ayase = kita_ayase_valid.station_facility_info.station_infos

    railway_line_ids_on_kita_ayase = station_infos_related_to_kita_ayase.pluck( :railway_line_id )

    it "includes information of Chiyoda Branch Line" do
      expect( chiyoda_branch ).to be_present
      expect( kita_ayase_valid.railway_line_id ).to eq( chiyoda_branch.id )

      expect( railway_line_ids_on_kita_ayase.length ).to eq(1)
      expect( ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).to_a.length ).to eq(1)
      expect( railway_line_ids_on_kita_ayase ).to eq( [ chiyoda_branch.id ] )
    end

    tokyo_metro_lines_on_kita_ayase = ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).tokyo_metro

    it "has scope \'\#tokyo_metro\'" do
      expect( tokyo_metro_lines_on_kita_ayase.to_a.length ).to eq(1)
      expect( tokyo_metro_lines_on_kita_ayase.map( &:id ) ).to eq( [ chiyoda_branch.id ] )
    end

    it "has scope \'\#to_main_lines\'" do
      expect( ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).tokyo_metro.to_main_lines.to_a.length ).to eq(1)
    end

    it "has scope \'\#select_branch_lines\'" do
      expect( ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.to_a.length ).to eq(1)
      expect( ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.pluck( :id ).uniq.length ).to eq(1)
      expect( ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.pluck( :main_railway_line_id ).uniq.length ).to eq(1)
      expect( ::RailwayLine.where( id: railway_line_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.pluck( :main_railway_line_id ).uniq ).to eq( [ chiyoda.id ] )
    end
  end

  describe "Marunouchi Line" do
    railway_lines = {
      main: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" ) ,
      branch: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
    }

    railway_lines.each do | k , railway_line |
      it "has info of #{k} line." do
        expect( railway_line ).to be_present
      end
    end

  end

end
