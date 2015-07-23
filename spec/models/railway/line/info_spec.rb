require 'rails_helper'

RSpec.describe Railway::Line::Info, :type => :model do

  columns = [
    :same_as ,
    :name_ja_normal ,
    :name_en_normal ,
    :name_ja_with_operator_name ,
    :name_en_with_operator_name ,
    :name_ja_with_operator_name_precise ,
    :name_en_with_operator_name_precise ,
    :css_class
  ]

  # a = ::Railway::Line::Info.all.to_a.map { | item | columns.map { | column | item.send( column ) } }

  railway_line_infos_in_db = [
    ["odpt.Railway:TokyoMetro.Ginza", "銀座線", "Ginza Line", "銀座線", "Ginza Line", "東京メトロ銀座線", "Tokyo Metro Ginza Line", "ginza"],
    ["odpt.Railway:TokyoMetro.Marunouchi", "丸ノ内線", "Marunouchi Line", "丸ノ内線", "Marunouchi Line", "東京メトロ丸ノ内線", "Tokyo Metro Marunouchi Line", "marunouchi"],
    ["odpt.Railway:TokyoMetro.MarunouchiBranch", "丸ノ内線（中野坂上 - 方南町）", "Marunouchi Line (Nakano-sakaue - Honancho)", "丸ノ内線（中野坂上 - 方南町）", "Marunouchi Line (Nakano-sakaue - Honancho)", "東京メトロ丸ノ内線（中野坂上 - 方南町）", "Tokyo Metro Marunouchi Line (Nakano-sakaue - Honancho)", "marunouchi_branch"],
    ["odpt.Railway:TokyoMetro.Hibiya", "日比谷線", "Hibiya Line", "日比谷線", "Hibiya Line", "東京メトロ日比谷線", "Tokyo Metro Hibiya Line", "hibiya"],
    ["odpt.Railway:TokyoMetro.Tozai", "東西線", "Tozai Line", "東西線", "Tozai Line", "東京メトロ東西線", "Tokyo Metro Tozai Line", "tozai"],
    ["odpt.Railway:TokyoMetro.Chiyoda", "千代田線", "Chiyoda Line", "千代田線", "Chiyoda Line", "東京メトロ千代田線", "Tokyo Metro Chiyoda Line", "chiyoda"],
    ["odpt.Railway:TokyoMetro.ChiyodaBranch", "千代田線（綾瀬 - 北綾瀬）", "Chiyoda Line (Ayase - Kita-ayase)", "千代田線（綾瀬 - 北綾瀬）", "Chiyoda Line (Ayase - Kita-ayase)", "東京メトロ千代田線（綾瀬 - 北綾瀬）", "Tokyo Metro Chiyoda Line (Ayase - Kita-ayase)", "chiyoda_branch"],
    ["odpt.Railway:TokyoMetro.Yurakucho", "有楽町線", "Yurakucho Line", "有楽町線", "Yurakucho Line", "東京メトロ有楽町線", "Tokyo Metro Yurakucho Line", "yurakucho"],
    ["odpt.Railway:TokyoMetro.Hanzomon", "半蔵門線", "Hanzomon Line", "半蔵門線", "Hanzomon Line", "東京メトロ半蔵門線", "Tokyo Metro Hanzomon Line", "hanzomon"],
    ["odpt.Railway:TokyoMetro.Namboku", "南北線", "Namboku Line", "南北線", "Namboku Line", "東京メトロ南北線", "Tokyo Metro Namboku Line", "namboku"],
    ["odpt.Railway:TokyoMetro.Fukutoshin", "副都心線", "Fukutoshin Line", "副都心線", "Fukutoshin Line", "東京メトロ副都心線", "Tokyo Metro Fukutoshin Line", "fukutoshin"],
    ["odpt.Railway:Toei.Asakusa", "浅草線", "Asakusa Line", "都営浅草線", "Toei Asakusa Line", "都営浅草線", "Toei Asakusa Line", "toei_asakusa"],
    ["odpt.Railway:Toei.Mita", "三田線", "Mita Line", "都営三田線", "Toei Mita Line", "都営三田線", "Toei Mita Line", "toei_mita"],
    ["odpt.Railway:Toei.Shinjuku", "新宿線", "Shinjuku Line", "都営新宿線", "Toei Shinjuku Line", "都営新宿線", "Toei Shinjuku Line", "toei_shinjuku"],
    ["odpt.Railway:Toei.Oedo", "大江戸線", "Oedo Line", "都営大江戸線", "Toei Oedo Line", "都営大江戸線", "Toei Oedo Line", "toei_oedo"],
    ["odpt.Railway:Toei.NipporiToneri", "日暮里・舎人ライナー", "Nippori Toneri Liner", "日暮里・舎人ライナー", "Nippori Toneri Liner", "都営日暮里・舎人ライナー", "Toei Nippori Toneri Liner", "nippori_toneri"],
    ["odpt.Railway:Toei.TodenArakawa", "荒川線", "Arakawa Line", "都電荒川線", "Toden Arakawa Line", "都電荒川線", "Toden Arakawa Line", "toden_arakawa"],
    ["odpt.Railway:JR-East", "JR各線", "JR Lines", "JR各線", "JR Lines", "JR各線", "JR Lines", "jrs"],
    ["odpt.Railway:JR-East.Yamanote", "山手線", "Yamanote Line", "JR山手線", "JR Yamanote Line", "JR山手線", "JR Yamanote Line", "jr_yamanote"],
    ["odpt.Railway:JR-East.KeihinTohoku", "京浜東北線", "Keihin-Tohoku Line", "JR京浜東北線", "JR Keihin-Tohoku Line", "JR京浜東北線", "JR Keihin-Tohoku Line", "jr_keihin_tohoku"],
    ["odpt.Railway:JR-East.Tokaido", "東海道線", "Tokaido Line", "JR東海道線", "JR Tokaido Line", "JR東海道線", "JR Tokaido Line", "jr_tokaido"],
    ["odpt.Railway:JR-East.Yokosuka", "横須賀線", "Yokosuka Line", "JR横須賀線", "JR Yokosuka Line", "JR横須賀線", "JR Yokosuka Line", "jr_yokosuka"],
    ["odpt.Railway:JR-East.Takasaki", "高崎線", "Takasaki Line", "JR高崎線", "JR Takasaki Line", "JR高崎線", "JR Takasaki Line", "jr_takasaki"],
    ["odpt.Railway:JR-East.Utsunomiya", "宇都宮線", "Utsunomiya Line", "JR宇都宮線", "JR Utsunomiya Line", "JR宇都宮線", "JR Utsunomiya Line", "jr_utsunomiya"],
    ["odpt.Railway:JR-East.ShonanShinjuku", "湘南新宿ライン", "Shonan-Shinjuku Line", "JR湘南新宿ライン", "JR Shonan-Shinjuku Line", "JR湘南新宿ライン", "JR Shonan-Shinjuku Line", "jr_shonan_shinjuku"],
    ["odpt.Railway:JR-East.UenoTokyo", "上野東京ライン", "Ueno-Tokyo Line", "JR上野東京ライン", "JR Ueno-Tokyo Line", "JR上野東京ライン", "JR Ueno-Tokyo Line", "jr_ueno_tokyo"],
    ["odpt.Railway:JR-East.Chuo", "中央線 特急", "Chuo Line (Limited Express)", "JR中央線 特急", "JR Chuo Line (Limited Express)", "JR中央線 特急", "JR Chuo Line (Limited Express)", "jr_chuo_limited_exp"],
    ["odpt.Railway:JR-East.ChuoKaisoku", "中央線 快速", "Chuo Line (Rapid service)", "JR中央線 快速", "JR Chuo Line (Rapid service)", "JR中央線 快速", "JR Chuo Line (Rapid service)", "jr_chuo_rapid"],
    ["odpt.Railway:JR-East.ChuoSobu", "中央・総武線 各駅停車", "Chuo and Sobu Line (Local service)", "JR中央・総武線 各駅停車", "JR Chuo and Sobu Line (Local service)", "JR中央・総武線 各駅停車", "JR Chuo and Sobu Line (Local service)", "jr_chuo_and_sobu_local"],
    ["odpt.Railway:JR-East.ChuoTozai", "中央・総武線 各駅停車（東西線直通 中野 - 三鷹）", "Chuo and Sobu Line (Local service, between Nakano and Mitaka)", "JR中央・総武線 各駅停車（東西線直通 中野 - 三鷹）", "JR Chuo and Sobu Line (Local service, between Nakano and Mitaka)", "JR中央・総武線 各駅停車（東西線直通 中野 - 三鷹）", "JR Chuo and Sobu Line (Local service, between Nakano and Mitaka)", "jr_chuo_and_sobu_local_between_nakano_and_mitaka"],
    ["odpt.Railway:JR-East.SobuTozai", "中央・総武線 各駅停車（東西線直通 西船橋 - 津田沼）", "Chuo and Sobu Line (Local service, between Nishi-funabashi and Tsudanuma)", "JR中央・総武線 各駅停車（東西線直通 西船橋 - 津田沼）", "JR Chuo and Sobu Line (Local service, between Nishi-funabashi and Tsudanuma)", "JR中央・総武線 各駅停車（東西線直通 西船橋 - 津田沼）", "JR Chuo and Sobu Line (Local service, between Nishi-funabashi and Tsudanuma)", "jr_chuo_and_sobu_local_between_nishi_funabashi_and_tsudanuma"],
    ["odpt.Railway:JR-East.Sobu", "総武快速線", "Sobu Line (Rapid service)", "JR総武快速線", "JR Sobu Line (Rapid service)", "JR総武快速線", "JR Sobu Line (Rapid service)", "jr_sobu_rapid"],
    ["odpt.Railway:JR-East.NaritaExpress", "成田エクスプレス", "Narita Express", "JR成田エクスプレス", "JR Narita Express", "JR成田エクスプレス", "JR Narita Express", "jr_narita_exp"],
    ["odpt.Railway:JR-East.Saikyo", "埼京線", "Saikyo Line", "JR埼京線", "JR Saikyo Line", "JR埼京線", "JR Saikyo Line", "jr_saikyo"],
    ["odpt.Railway:JR-East.Joban", "常磐線", "Joban Line", "JR常磐線", "JR Joban Line", "JR常磐線", "JR Joban Line", "jr_joban"],
    ["odpt.Railway:JR-East.Keiyo", "京葉線", "Keiyo Line", "JR京葉線", "JR Keiyo Line", "JR京葉線", "JR Keiyo Line", "jr_keiyo"],
    ["odpt.Railway:JR-East.Musashino", "武蔵野線", "Musashino Line", "JR武蔵野線", "JR Musashino Line", "JR武蔵野線", "JR Musashino Line", "jr_musashino"],
    ["odpt.Railway:JR-East.Shinkansen", "東北・秋田・山形・上越・長野新幹線", "Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen", "東北・秋田・山形・上越・長野新幹線", "Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen", "JR東北・秋田・山形・上越・長野新幹線", "Tohoku, Akita, Yamagata, Joetsu and Nagano Shinkansen", "shinkansen_e"],
    ["odpt.Railway:JR-East.Shinkansen.2015", "東北・秋田・山形・上越・北陸新幹線", "Tohoku, Akita, Yamagata, Joetsu and Hokuriku Shinkansen", "東北・秋田・山形・上越・北陸新幹線", "Tohoku, Akita, Yamagata, Joetsu and Hokuriku Shinkansen", "JR東北・秋田・山形・上越・北陸新幹線", "Tohoku, Akita, Yamagata, Joetsu and Hokuriku Shinkansen", "shinkansen_e"],
    ["odpt.Railway:JR-East.Shinkansen.2016", "東北・北海道・秋田・山形・上越・北陸新幹線", "Tohoku, Hokkaido, Akita, Yamagata, Joetsu and Hokuriku Shinkansen", "東北・北海道・秋田・山形・上越・北陸新幹線", "Tohoku, Hokkaido, Akita, Yamagata, Joetsu and Hokuriku Shinkansen", "JR東北・北海道・秋田・山形・上越・北陸新幹線", "Tohoku, Hokkaido, Akita, Yamagata, Joetsu and Hokuriku Shinkansen", "shinkansen_e"],
    ["odpt.Railway:JR-Central.Shinkansen", "東海道・山陽新幹線", "Tokaido and Sanyo Shinkansen", "東海道・山陽新幹線", "Tokaido and Sanyo Shinkansen", "JR東海道・山陽新幹線", "Tokaido and Sanyo Shinkansen", "shinkansen_c"],
    ["odpt.Railway:Tokyu.Toyoko", "東横線", "Toyoko Line", "東急東横線", "Tokyu Toyoko Line", "東急東横線", "Tokyu Toyoko Line", "tokyu_toyoko"],
    ["odpt.Railway:Tokyu.Meguro", "目黒線", "Meguro Line", "東急目黒線", "Tokyu Meguro Line", "東急目黒線", "Tokyu Meguro Line", "tokyu_meguro"],
    ["odpt.Railway:Tokyu.DenEnToshi", "田園都市線", "Den-en-toshi Line", "東急田園都市線", "Tokyu Den-en-toshi Line", "東急田園都市線", "Tokyu Den-en-toshi Line", "tokyu_den_en_toshi"],
    ["odpt.Railway:YokohamaMinatomiraiRailway.Minatomirai", "みなとみらい線", "Minatomirai Line", "横浜高速鉄道みなとみらい線", "Yokohama Minatomirai Railway Company Minatomirai Line", "横浜高速鉄道みなとみらい線", "Yokohama Minatomirai Railway Company Minatomirai Line", "yokohama_minatomirai_mm"],
    ["odpt.Railway:Odakyu.Odawara", "小田原線", "Odawara Line", "小田急小田原線", "Odakyu Odawara Line", "小田急小田原線", "Odakyu Odawara Line", "odakyu_odawara"],
    ["odpt.Railway:Odakyu.Tama", "多摩線", "Tama Line", "小田急多摩線", "Odakyu Tama Line", "小田急多摩線", "Odakyu Tama Line", "odakyu_tama"],
    ["odpt.Railway:Odakyu.Enoshima", "江ノ島線", "Enoshima Line", "小田急江ノ島線", "Odakyu Enoshima Line", "小田急江ノ島線", "Odakyu Enoshima Line", "odakyu_enoshima"],
    ["odpt.Railway:HakoneTozan.Rail.OdawaraSide", "箱根登山鉄道線（小田原 - 箱根湯本）", "Hakone Tozan Line", "箱根登山鉄道線（小田原 - 箱根湯本）", "Hakone Tozan Line", "箱根登山鉄道線（小田原 - 箱根湯本）", "Hakone Tozan Line", "hakone_tozan"],
    ["odpt.Railway:HakoneTozan.Rail.GoraSide", "箱根登山鉄道線（箱根湯本 - 強羅）", "Hakone Tozan Line", "箱根登山鉄道線（箱根湯本 - 強羅）", "Hakone Tozan Line", "箱根登山鉄道線（箱根湯本 - 強羅）", "Hakone Tozan Line", "hakone_tozan"],
    ["odpt.Railway:Seibu.Ikebukuro", "池袋線", "Ikebukuro Line", "西武池袋線", "Seibu Ikebukuro Line", "西武池袋線", "Seibu Ikebukuro Line", "seibu_ikebukuro"],
    ["odpt.Railway:Seibu.SeibuChichibu", "秩父線", "Chichibu Line", "西武秩父線", "Seibu Chichibu Line", "西武秩父線", "Seibu Chichibu Line", "seibu_chichibu"],
    ["odpt.Railway:Seibu.Toshima", "豊島線", "Toshima Line", "西武豊島線", "Seibu Toshima Line", "西武豊島線", "Seibu Toshima Line", "seibu_toshima"],
    ["odpt.Railway:Seibu.Sayama", "狭山線", "Sayama Line", "西武狭山線", "Seibu Sayama Line", "西武狭山線", "Seibu Sayama Line", "seibu_sayama"],
    ["odpt.Railway:Seibu.SeibuYurakucho", "西武有楽町線", "Seibu Yurakucho Line", "西武有楽町線", "Seibu Yurakucho Line", "西武有楽町線", "Seibu Yurakucho Line", "seibu_yurakucho"],
    ["odpt.Railway:Seibu.Shinjuku", "新宿線", "Shinjuku Line", "西武新宿線", "Seibu Shinjuku Line", "西武新宿線", "Seibu Shinjuku Line", "seibu_shinjuku"],
    ["odpt.Railway:Tobu.SkyTreeIsesaki", "スカイツリーライン（伊勢崎線）", "Sky Tree and Isesaki Line", "東武スカイツリーライン（伊勢崎線）", "Tobu Sky Tree and Isesaki Line", "東武スカイツリーライン（伊勢崎線）", "Tobu Sky Tree and Isesaki Line", "tobu_sky_tree_and_isesaki"],
    ["odpt.Railway:Tobu.SkyTreeOshiage", "スカイツリーライン（押上 - 曳舟）", "Sky Tree Line (Oshiage - Hikifune)", "東武スカイツリーライン（押上 - 曳舟）", "Tobu Sky Tree Line (Oshiage - Hikifune)", "東武スカイツリーライン（押上 - 曳舟）", "Tobu Sky Tree Line (Oshiage - Hikifune)", "tobu_sky_tree_oshiage_hikifune"],
    ["odpt.Railway:Tobu.SkyTree", "スカイツリーライン", "Sky Tree Line", "東武スカイツリーライン", "Tobu Sky Tree Line", "東武スカイツリーライン", "Tobu Sky Tree Line", "tobu_sky_tree"],
    ["odpt.Railway:Tobu.Isesaki", "伊勢崎線", "Isesaki Line", "東武伊勢崎線", "Tobu Isesaki Line", "東武伊勢崎線", "Tobu Isesaki Line", "tobu_isesaki"],
    ["odpt.Railway:Tobu.Nikko", "日光線", "Nikko Line", "東武日光線", "Tobu Nikko Line", "東武日光線", "Tobu Nikko Line", "tobu_nikko"],
    ["odpt.Railway:Tobu.Kinugawa", "鬼怒川線", "Kinugawa Line", "東武鬼怒川線", "Tobu Kinugawa Line", "東武鬼怒川線", "Tobu Kinugawa Line", "tobu_kinugawa"],
    ["odpt.Railway:Tobu.Tojo", "東上線", "Tojo Line", "東武東上線", "Tobu Tojo Line", "東武東上線", "Tobu Tojo Line", "tobu_tojo"],
    ["odpt.Railway:SaitamaRailway.SaitamaRailway", nil, nil, "埼玉高速鉄道", "Saitama Railway", "埼玉高速鉄道", "Saitama Railway", "saitama"],
    ["odpt.Railway:ToyoRapidRailway.ToyoRapidRailway", nil, nil, "東葉高速鉄道", "Toyo Rapid Railway", "東葉高速鉄道", "Toyo Rapid Railway", "toyo_rapid"],
    ["odpt.Railway:Keio.Keio", "京王線", "Keio Line", "京王線", "Keio Line", "京王線", "Keio Line", "keio_line"],
    ["odpt.Railway:Keio.New", "新線", "New Line", "京王新線", "Keio New Line", "京王新線", "Keio New Line", "keio_new"],
    ["odpt.Railway:Keio.Inokashira", "井の頭線", "Inokashira Line", "京王井の頭線", "Keio Inokashira Line", "京王井の頭線", "Keio Inokashira Line", "keio_inokashira"],
    ["odpt.Railway:Keisei.KeiseiMain", "本線", "Main Line", "京成本線", "Keisei Main Line", "京成本線", "Keisei Main Line", "keisei_main"],
    ["odpt.Railway:Keisei.KeiseiOshiage", "押上線", "Oshiage Line", "京成押上線", "Keisei Oshiage Line", "京成押上線", "Keisei Oshiage Line", "keisei_oshiage"],
    ["odpt.Railway:MIR.TX", nil, nil, "つくばエクスプレス", "Tsukuba Express", "つくばエクスプレス", "Tsukuba Express", "tsukuba_exp"],
    ["odpt.Railway:Yurikamome.Yurikamome", "ゆりかもめ", "Yurikamome", "ゆりかもめ", "Yurikamome", "ゆりかもめ", "Yurikamome", "yurikamome_line"],
    ["odpt.Railway:TWR.Rinkai", nil, nil, "りんかい線", "Rinkai Line", "りんかい線", "Rinkai Line", "rinkai"],
    ["odpt.Railway:Undefined", "未定義", "Undefined", "未定義", "Undefined", "未定義", "Undefined", "undefined"]
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

  check_infos_in_db( railway_line_infos_in_db , ::Railway::Line::Info , columns )

end
