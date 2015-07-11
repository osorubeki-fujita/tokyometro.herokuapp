require 'rails_helper'

RSpec.describe Operator, :type => :model do
  columns = [
    :same_as ,
    :name_ja_short ,
    :name_en_short ,
    :name_ja_normal_precise ,
    :name_ja_normal ,
    :name_ja_for_transfer_info ,
    :name_ja_very_precise ,
    :name_en_normal_precise ,
    :name_en_normal ,
    :name_en_for_transfer_info ,
    :name_en_very_precise ,
    :css_class
  ]

  operator_infos_in_db = [
    ["odpt.Operator:TokyoMetro", "", "", "東京メトロ", "東京メトロ", "", "東京メトロ（東京地下鉄）", "Tokyo Metro", "Tokyo Metro", "", "Tokyo Metro", "tokyo_metro"],
    ["odpt.Operator:Toei", "都営", "Toei", "都営地下鉄", "都営", "都営", "都営地下鉄（東京都交通局）", "Toei Subway", "Toei", "Toei", "Toei Subway (Bureau of Transportation Tokyo Metropolitan Government)", "toei_subway"],
    ["odpt.Operator:ToeiNipporiToneri", "", "", "都営", "都営", "", "日暮里・舎人ライナー", "Toei", "Toei", "", "Nippori Toneri Liner", "toei"],
    ["odpt.Operator:Toden", "", "", "都電", "都電", "都電", "都電（東京都交通局）", "Toden", "Toden", "Toden", "Toden (Bureau of Transportation Tokyo Metropolitan Government)", "toden"],
    ["odpt.Operator:JR-East", "JR", "JR", "JR東日本", "JR", "JR", "JR東日本（東日本旅客鉄道）", "JR East", "JR", "JR", "JR East (East Japan Railway Company)", "jr_east"],
    ["odpt.Operator:JR-Central", "JR", "JR", "JR東海", "JR", "JR", "JR東海（東海旅客鉄道）", "JR Central", "JR", "JR", "JR Central (Central Japan Railway Company)", "jr_central"],
    ["odpt.Operator:Tokyu", "東急", "Tokyu", "東急電鉄", "東急", "東急", "東急電鉄（東京急行電鉄）", "Tokyu Corporation", "Tokyu", "Tokyu", "Tokyu Corporation", "tokyu"],
    ["odpt.Operator:YokohamaMinatomiraiRailway", "", "", "横浜高速鉄道", "横浜高速鉄道", "横浜高速鉄道", "横浜高速鉄道", "Yokohama Minatomirai Railway Company", "Yokohama Minatomirai Railway Company", "Yokohama Minatomirai Railway Company", "Yokohama Minatomirai Railway Company", "yokohama_minatomirai"],
    ["odpt.Operator:Odakyu", "小田急", "Odakyu", "小田急電鉄", "小田急", "小田急", "小田急電鉄", "Odakyu Electric Railway", "Odakyu", "Odakyu", "Odakyu Electric Railway", "odakyu"],
    ["odpt.Operator:HakoneTozan", "箱根登山", "Hakone Tozan", "箱根登山鉄道", "箱根登山", "箱根登山", "箱根登山鉄道", "Hakone Tozan Railway", "Hakone Tozan", "Hakone Tozan", "Hakone Tozan Railway", "hakone_tozan"],
    ["odpt.Operator:Seibu", "西武", "Seibu", "西武鉄道", "西武", "西武", "西武鉄道", "Seibu Railway", "Seibu", "Seibu", "Seibu Railway", "seibu"],
    ["odpt.Operator:Tobu", "東武", "Tobu", "東武鉄道", "東武", "東武", "東武鉄道", "Tobu Railway", "Tobu", "Tobu", "Tobu Railway", "tobu"],
    ["odpt.Operator:SaitamaRailway", "", "", "埼玉高速鉄道", "埼玉高速鉄道", "埼玉高速鉄道", "埼玉高速鉄道", "Saitama Railway", "Saitama Railway", "Saitama Railway", "Saitama Railway", "saitama"],
    ["odpt.Operator:ToyoRapidRailway", "", "", "東葉高速鉄道", "東葉高速鉄道", "東葉高速鉄道", "東葉高速鉄道", "Toyo Rapid Railway", "Toyo Rapid Railway", "Toyo Rapid Railway", "Toyo Rapid Railway", "toyo_rapid"],
    ["odpt.Operator:Keio", "京王", "Keio", "京王電鉄", "京王", "京王", "京王電鉄", "Keio Corporation", "Keio", "Keio", "Keio Corporation", "keio"],
    ["odpt.Operator:Keisei", "京成", "Keisei", "京成電鉄", "京成", "京成", "京成電鉄", "Keisei Electric Railway", "Keisei", "Keisei", "Keisei Electric Railway", "keisei"],
    ["odpt.Operator:MIR", "", "", "つくばエクスプレス", "つくばエクスプレス", "つくばエクスプレス", "つくばエクスプレス（首都圏新都市鉄道）", "Tsukuba Express", "Tsukuba Express", "Tsukuba Express", "Tsukuba Express (MIR / Metropolitan Intercity Railway)", "tsukuba_exp"],
    ["odpt.Operator:Yurikamome", "", "", "ゆりかもめ", "ゆりかもめ", "ゆりかもめ", "ゆりかもめ", "Yurikamome", "Yurikamome", "Yurikamome", "Yurikamome", "yurikamome"],
    ["odpt.Operator:TWR", "", "", "りんかい線", "りんかい線", "りんかい線", "りんかい線（東京臨海高速鉄道）", "Rinkai Line", "Rinkai Line", "Rinkai Line", "Rinkai Line (TWR / Tokyo Waterfront Area Rapid Transit)", "rinkai"],
    ["odpt.Operator:Undefined", "" , "" , "未定義", "未定義", "未定義", "未定義", "Undefined", "Undefined", "Undefined", "Undefined", "undefined"]
  ]

  operator_infos_in_db.each do | operator_info_in_db |
    same_as = operator_info_in_db
    o = ::Operator.find_by( same_as: same_as )
    it 'is present.' do
      expect(o).to be_present
    end

    it 'has valid infos ' do
      for i in 1..( columns.length - 1 )
        info_of_o = o.send( columns[i] )
        valid_info = operator_info_in_db[i]
        if valid_info.blank?
          expect( info_of_o ).to be_blank
        else
          expect( info_of_o ).to eq( valid_info )
        end
      end
    end

  end
end
