require 'rails_helper'

RSpec.describe Railway::Line::Info, :type => :model do
  columns_for_check_css_class = [ :same_as , :css_class ]

  railway_line_and_css_class = [
    ["odpt.Railway:TokyoMetro.Ginza", "ginza"],
    ["odpt.Railway:TokyoMetro.Marunouchi", "marunouchi"],
    ["odpt.Railway:TokyoMetro.MarunouchiBranch", "marunouchi_branch"],
    ["odpt.Railway:TokyoMetro.Hibiya", "hibiya"],
    ["odpt.Railway:TokyoMetro.Tozai", "tozai"],
    ["odpt.Railway:TokyoMetro.Chiyoda", "chiyoda"],
    ["odpt.Railway:TokyoMetro.ChiyodaBranch", "chiyoda_branch"],
    ["odpt.Railway:TokyoMetro.Yurakucho", "yurakucho"],
    ["odpt.Railway:TokyoMetro.Hanzomon", "hanzomon"],
    ["odpt.Railway:TokyoMetro.Namboku", "namboku"],
    ["odpt.Railway:TokyoMetro.Fukutoshin", "fukutoshin"],
    ["odpt.Railway:Toei.Asakusa", "toei_asakusa"],
    ["odpt.Railway:Toei.Mita", "toei_mita"],
    ["odpt.Railway:Toei.Shinjuku", "toei_shinjuku"],
    ["odpt.Railway:Toei.Oedo", "toei_oedo"],
    ["odpt.Railway:Toei.NipporiToneri", "nippori_toneri"],
    ["odpt.Railway:Toei.TodenArakawa", "toden_arakawa"],
    ["odpt.Railway:JR-East", "jrs"],
    ["odpt.Railway:JR-East.Yamanote", "jr_yamanote"],
    ["odpt.Railway:JR-East.KeihinTohoku", "jr_keihin_tohoku"],
    ["odpt.Railway:JR-East.Tokaido", "jr_tokaido"],
    ["odpt.Railway:JR-East.Yokosuka", "jr_yokosuka"],
    ["odpt.Railway:JR-East.Takasaki", "jr_takasaki"],
    ["odpt.Railway:JR-East.Utsunomiya", "jr_utsunomiya"],
    ["odpt.Railway:JR-East.ShonanShinjuku", "jr_shonan_shinjuku"],
    ["odpt.Railway:JR-East.UenoTokyo", "jr_ueno_tokyo"],
    ["odpt.Railway:JR-East.Chuo", "jr_chuo_limited_exp"],
    ["odpt.Railway:JR-East.ChuoKaisoku", "jr_chuo_rapid"],
    ["odpt.Railway:JR-East.ChuoSobu", "jr_chuo_and_sobu_local"],
    ["odpt.Railway:JR-East.ChuoTozai", "jr_chuo_and_sobu_local_between_nakano_and_mitaka"],
    ["odpt.Railway:JR-East.SobuTozai", "jr_chuo_and_sobu_local_between_nishi_funabashi_and_tsudanuma"],
    ["odpt.Railway:JR-East.Sobu", "jr_sobu_rapid"],
    ["odpt.Railway:JR-East.NaritaExpress", "jr_narita_exp"],
    ["odpt.Railway:JR-East.Saikyo", "jr_saikyo"],
    ["odpt.Railway:JR-East.Joban", "jr_joban"],
    ["odpt.Railway:JR-East.Keiyo", "jr_keiyo"],
    ["odpt.Railway:JR-East.Musashino", "jr_musashino"],
    ["odpt.Railway:JR-East.Shinkansen", "shinkansen_e"],
    ["odpt.Railway:JR-Central.Shinkansen", "shinkansen_c"],
    ["odpt.Railway:Tokyu.Toyoko", "tokyu_toyoko"],
    ["odpt.Railway:Tokyu.Meguro", "tokyu_meguro"],
    ["odpt.Railway:Tokyu.DenEnToshi", "tokyu_den_en_toshi"],
    ["odpt.Railway:YokohamaMinatomiraiRailway.Minatomirai", "yokohama_minatomirai_mm"],
    ["odpt.Railway:Odakyu.Odawara", "odakyu_odawara"],
    ["odpt.Railway:Odakyu.Tama", "odakyu_tama"],
    ["odpt.Railway:Odakyu.Enoshima", "odakyu_enoshima"],
    ["odpt.Railway:HakoneTozan.Rail.OdawaraSide", "hakone_tozan"],
    ["odpt.Railway:HakoneTozan.Rail.GoraSide", "hakone_tozan"],
    ["odpt.Railway:Seibu.Ikebukuro", "seibu_ikebukuro"],
    ["odpt.Railway:Seibu.SeibuChichibu", "seibu_chichibu"],
    ["odpt.Railway:Seibu.Toshima", "seibu_toshima"],
    ["odpt.Railway:Seibu.Sayama", "seibu_sayama"],
    ["odpt.Railway:Seibu.SeibuYurakucho", "seibu_yurakucho"],
    ["odpt.Railway:Seibu.Shinjuku", "seibu_shinjuku"],
    ["odpt.Railway:Tobu.SkyTreeIsesaki", "tobu_sky_tree_and_isesaki"],
    ["odpt.Railway:Tobu.SkyTreeOshiage", "tobu_sky_tree_oshiage_hikifune"],
    ["odpt.Railway:Tobu.SkyTree", "tobu_sky_tree"],
    ["odpt.Railway:Tobu.Isesaki", "tobu_isesaki"],
    ["odpt.Railway:Tobu.Nikko", "tobu_nikko"],
    ["odpt.Railway:Tobu.Kinugawa", "tobu_kinugawa"],
    ["odpt.Railway:Tobu.Tojo", "tobu_tojo"],
    ["odpt.Railway:SaitamaRailway.SaitamaRailway", "saitama"],
    ["odpt.Railway:ToyoRapidRailway.ToyoRapidRailway", "toyo_rapid"],
    ["odpt.Railway:Keio.Keio", "keio_line"],
    ["odpt.Railway:Keio.New", "keio_new"],
    ["odpt.Railway:Keio.Inokashira", "keio_inokashira"],
    ["odpt.Railway:Keisei.KeiseiMain", "keisei_main"],
    ["odpt.Railway:Keisei.KeiseiOshiage", "keisei_oshiage"],
    ["odpt.Railway:MIR.TX", "tsukuba_exp"],
    ["odpt.Railway:Yurikamome.Yurikamome", "yurikamome_line"],
    ["odpt.Railway:TWR.Rinkai", "rinkai"],
    ["odpt.Railway:Undefined", "undefined"],
    ["odpt.Railway:JR-East.Shinkansen.2015", "shinkansen_e"],
    ["odpt.Railway:JR-East.Shinkansen.2016", "shinkansen_e"]
  ]

  describe "As for Kita-ayase" do
    chiyoda_branch = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" )
    chiyoda = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )

    kita_ayase_valid = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )
    station_infos_related_to_kita_ayase = kita_ayase_valid.station_facility_info.station_infos

    railway_line_info_ids_on_kita_ayase = station_infos_related_to_kita_ayase.pluck( :railway_line_info_id )

    it "includes information of Chiyoda Branch Line" do
      expect( chiyoda_branch ).to be_present
      expect( kita_ayase_valid.railway_line_info_id ).to eq( chiyoda_branch.id )

      expect( railway_line_info_ids_on_kita_ayase.length ).to eq(1)
      expect( ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).to_a.length ).to eq(1)
      expect( railway_line_info_ids_on_kita_ayase ).to eq( [ chiyoda_branch.id ] )
    end

    tokyo_metro_lines_on_kita_ayase = ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).tokyo_metro

    it "has scope \'\#tokyo_metro\'" do
      expect( tokyo_metro_lines_on_kita_ayase.to_a.length ).to eq(1)
      expect( tokyo_metro_lines_on_kita_ayase.map( &:id ) ).to eq( [ chiyoda_branch.id ] )
    end

    it "has scope \'\#to_main_lines\'" do
      expect( ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).tokyo_metro.to_main_lines.to_a.length ).to eq(1)
    end

    it "has scope \'\#select_branch_lines\'" do
      expect( ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.to_a.length ).to eq(1)
      expect( ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.pluck( :id ).uniq.length ).to eq(1)
      expect( ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.pluck( :main_railway_line_info_id ).uniq.length ).to eq(1)
      expect( ::Railway::Line::Info.where( id: railway_line_info_ids_on_kita_ayase ).tokyo_metro.select_branch_lines.pluck( :main_railway_line_info_id ).uniq ).to eq( [ chiyoda.id ] )
    end
  end

  describe "Marunouchi Line" do
    railway_line_infos = {
      main: ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" ) ,
      branch: ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
    }

    railway_line_infos.each do | k , railway_line |
      it "has info of #{k} line." do
        expect( railway_line ).to be_present
      end
    end

  end

  describe "Css class" do
    railway_line_and_css_class.each do | railway_line_same_as , valid_css_class |
      r = ::Railway::Line::Info.find_by( same_as: railway_line_same_as )
      it "is present" do
        # puts r.same_as
        expect(r).to be_present
      end
      it "has method 'css_class'." do
        expect( r.css_class ).to eq( valid_css_class )
      end
    end
  end

end
