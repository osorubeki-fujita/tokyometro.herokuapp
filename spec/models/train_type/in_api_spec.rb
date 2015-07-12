require 'rails_helper'

RSpec.describe TrainType::InApi, :type => :model do

  train_types_in_api_and_their_infos = [
    ["odpt.TrainType:TokyoMetro.Local", "各停", nil, "各停", "Local", nil, "Local"],
    ["odpt.TrainType:TokyoMetro.LimitedExpress", "特急", nil, "特急", "Limited Express", nil, "Limited Express"],
    ["odpt.TrainType:TokyoMetro.Express", "急行", nil, "急行", "Express", nil, "Express"],
    ["odpt.TrainType:TokyoMetro.HolidayExpress", "土休急行", "急行", "急行", "Express (Holiday)", "Express", "Express"],
    ["odpt.TrainType:TokyoMetro.SemiExpress", "準急", nil, "準急", "Semi Express", nil, "Semi Express"],
    ["odpt.TrainType:TokyoMetro.Rapid", "快速", nil, "快速", "Rapid", nil, "Rapid"],
    ["odpt.TrainType:TokyoMetro.CommuterRapid", "通勤快速", nil, "通勤快速", "Commuter Rapid", nil, "Commuter Rapid"],
    ["odpt.TrainType:TokyoMetro.ToyoRapid", "東葉快速", nil, "東葉快速", "Toyo Rapid", nil, "Toyo Rapid"],
    ["odpt.TrainType:TokyoMetro.TamaExpress", "多摩急行", nil, "多摩急行", "Tama Express", nil, "Tama Express"],
    [
      "odpt.TrainType:TokyoMetro.RomanceCar","特急ロマンスカー","特急","特急",
      "Limited Express \"Romance Car\"", nil , "Limited Express \"Romance Car\""
    ],
    ["odpt.TrainType:TokyoMetro.RapidExpress", "快速急行", nil, "快速急行", "Rapid Express", nil, "Rapid Express"],
    ["odpt.TrainType:TokyoMetro.CommuterLimitedExpress", "通勤特急", nil, "通勤特急", "Commuter Ltd. Exp.", nil, "Commuter Ltd. Exp."],
    ["odpt.TrainType:TokyoMetro.CommuterExpress", "通勤急行", nil, "通勤急行", "Commuter Express", nil, "Commuter Express"],
    ["odpt.TrainType:TokyoMetro.CommuterSemiExpress", "通勤準急", nil, "通勤準急", "Commuter Semi Express", nil, "Commuter Semi Express"],
    ["odpt.TrainType:TokyoMetro.Unknown", "不明", nil, "不明", "Unknown", nil, "Unknown"],
    ["odpt.TrainType:TokyoMetro.Extra", "臨時", nil, "臨時", "Extra", nil, "Extra"],
    ["odpt.TrainType:Toei.Local", "各停", nil, "各停", "Local", nil, "Local"],
    ["odpt.TrainType:Toei.Express", "急行", nil, "急行", "Express", nil, "Express"],
    ["odpt.TrainType:Toei.AirportLimitedExpress", "エアポート快特", nil, "エアポート快特", "Airport Limited Express", nil, "Airport Limited Express"]
  ]

  train_types_in_api_and_their_infos.each do | infos |
    same_as , name_ja , name_ja_short , name_ja_normal , name_en , name_en_short , name_en_normal = infos
    h = {
      same_as: same_as ,
      name_ja: name_ja ,
      name_ja_short: name_ja_short ,
      name_ja_normal: name_ja_normal ,
      name_en: name_en ,
      name_en_short: name_en_short ,
      name_en_normal: name_en_normal
    }
    t = ::TrainType::InApi.find_by( same_as: same_as )
    it "(#{ same_as }) is present" do
      expect(t).to be_present
    end
    it "(#{ same_as }) has db columns and methods" do
      h.each do | key , h_value |
        t_value = t.send( key )
        if t_value.blank?
          expect( h_value ).to be_blank
        else
          expect( t_value ).to eq( h_value )
        end
      end
    end
  end
end
