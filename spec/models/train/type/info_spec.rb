require 'rails_helper'

RSpec.describe Train::Type::Info , :type => :model do

  train_types_and_color_basenames = [["custom.TrainType:TokyoMetro.Ginza.Local.Normal", "train_type_ginza_local_normal"],
    ["custom.TrainType:TokyoMetro.Marunouchi.Local.Normal", "train_type_marunouchi_local_normal"],
    ["custom.TrainType:TokyoMetro.MarunouchiBranch.Local.Normal", "train_type_marunouchi_branch_local_normal"],
    ["custom.TrainType:TokyoMetro.Hibiya.Local.Normal", "train_type_hibiya_local_normal"],
    ["custom.TrainType:TokyoMetro.Tozai.Local.Normal", "train_type_tozai_local_normal"],
    ["custom.TrainType:TokyoMetro.Tozai.Local.ForMitaka", "train_type_tozai_local_for_mitaka"],
    ["custom.TrainType:TokyoMetro.Tozai.Local.ForTsudanuma", "train_type_tozai_local_for_tsudanuma"],
    ["custom.TrainType:TokyoMetro.Tozai.Local.ForToyoRapidRailway", "train_type_tozai_local_for_toyo_rapid_railway"],
    ["custom.TrainType:TokyoMetro.Tozai.CommuterRapid.Normal", "train_type_tozai_commuter_rapid_normal"],
    ["custom.TrainType:TokyoMetro.Tozai.CommuterRapid.ForMitaka", "train_type_tozai_commuter_rapid_for_mitaka"],
    ["custom.TrainType:TokyoMetro.Tozai.Rapid.Normal", "train_type_tozai_rapid_normal"],
    ["custom.TrainType:TokyoMetro.Tozai.Rapid.ForMitaka", "train_type_tozai_rapid_for_mitaka"],
    ["custom.TrainType:TokyoMetro.Tozai.Rapid.ForTsudanuma", "train_type_tozai_rapid_for_tsudanuma"],
    ["custom.TrainType:TokyoMetro.Tozai.Rapid.ForToyoRapidRailway", "train_type_tozai_rapid_for_toyo_rapid_railway"],
    ["custom.TrainType:TokyoMetro.Tozai.ToyoRapid.ForToyoRapidRailway", "train_type_tozai_toyo_rapid_for_toyo_rapid_railway"],
    ["custom.TrainType:TokyoMetro.Chiyoda.Local.Normal", "train_type_chiyoda_local_normal"],
    ["custom.TrainType:TokyoMetro.ChiyodaBranch.Local.Normal", "train_type_chiyoda_branch_local_normal"],
    ["custom.TrainType:TokyoMetro.Chiyoda.Local.ForJR", "train_type_chiyoda_local_for_jr"],
    ["custom.TrainType:TokyoMetro.Chiyoda.Local.ForOdakyu", "train_type_chiyoda_local_for_odakyu"],
    ["custom.TrainType:TokyoMetro.Chiyoda.SemiExpress.ForOdakyu", "train_type_chiyoda_semi_express_for_odakyu"],
    ["custom.TrainType:TokyoMetro.Chiyoda.TamaExpress.ForOdakyu", "train_type_chiyoda_tama_express_for_odakyu"],
    ["custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal", "train_type_chiyoda_romance_car_normal"],
    ["custom.TrainType:TokyoMetro.Hanzomon.Local.Normal", "train_type_hanzomon_local_normal"],
    ["custom.TrainType:TokyoMetro.Hanzomon.Local.ToTokyu", "train_type_hanzomon_local_to_tokyu"],
    ["custom.TrainType:TokyoMetro.Hanzomon.SemiExpress.ToTokyu", "train_type_hanzomon_semi_express_to_tokyu"],
    ["custom.TrainType:TokyoMetro.Hanzomon.HolidayExpress.ToTokyu", "train_type_hanzomon_holiday_express_to_tokyu"],
    ["custom.TrainType:TokyoMetro.Hanzomon.Express.ToTokyu", "train_type_hanzomon_express_to_tokyu"],
    ["custom.TrainType:TokyoMetro.Hanzomon.SemiExpress.ToTobu", "train_type_hanzomon_semi_express_to_tobu"],
    ["custom.TrainType:TokyoMetro.Hanzomon.Express.ToTobu", "train_type_hanzomon_express_to_tobu"],
    ["custom.TrainType:TokyoMetro.Namboku.Local.Normal", "train_type_namboku_local_normal"],
    ["custom.TrainType:TokyoMetro.Namboku.Local.ToTokyu", "train_type_namboku_local_to_tokyu"],
    ["custom.TrainType:TokyoMetro.Namboku.Express.ToTokyu", "train_type_namboku_express_to_tokyu"],
    ["custom.TrainType:TokyoMetro.Yurakucho.Local.Colored", "train_type_yurakucho_local_colored"],
    ["custom.TrainType:TokyoMetro.Fukutoshin.Local.Colored", "train_type_fukutoshin_local_colored"],
    ["custom.TrainType:TokyoMetro.Yurakucho.Local.Normal", "train_type_yurakucho_local_normal"],
    ["custom.TrainType:TokyoMetro.Fukutoshin.Local.Normal", "train_type_fukutoshin_local_normal"],
    ["custom.TrainType:TokyoMetro.Fukutoshin.CommuterExpress.Normal", "train_type_fukutoshin_commuter_express_normal"],
    ["custom.TrainType:TokyoMetro.Fukutoshin.HolidayExpress.Normal", "train_type_fukutoshin_holiday_express_normal"],
    ["custom.TrainType:TokyoMetro.Fukutoshin.Express.Normal", "train_type_fukutoshin_express_normal"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Local.ToSeibu", "train_type_yurakucho_fukutoshin_local_to_seibu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.SemiExpress.ToSeibu", "train_type_yurakucho_fukutoshin_semi_express_to_seibu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Rapid.ToSeibu", "train_type_yurakucho_fukutoshin_rapid_to_seibu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.RapidExpress.ToSeibu", "train_type_yurakucho_fukutoshin_rapid_express_to_seibu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Local.ToTobuTojo", "train_type_yurakucho_fukutoshin_local_to_tobu_tojo"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Local.ToTokyu", "train_type_yurakucho_fukutoshin_local_to_tokyu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Express.ToTokyu", "train_type_yurakucho_fukutoshin_express_to_tokyu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.CommuterLimitedExpress.ToTokyu", "train_type_yurakucho_fukutoshin_commuter_limited_express_to_tokyu"],
    ["custom.TrainType:TokyoMetro.YurakuchoFukutoshin.LimitedExpress.ToTokyu", "train_type_yurakucho_fukutoshin_limited_express_to_tokyu"],
    ["custom.TrainType:Toei.Asakusa.Local.Normal", "train_type_toei_asakusa_local_normal"],
    ["custom.TrainType:Toei.Asakusa.AirportLimitedExpress.Normal", "train_type_toei_asakusa_airport_limited_express_normal"],
    ["custom.TrainType:Toei.Mita.Local.Normal", "train_type_toei_mita_local_normal"],
    ["custom.TrainType:Toei.Mita.Local.ToTokyu", "train_type_toei_mita_local_to_tokyu"],
    ["custom.TrainType:Toei.Mita.Express.ToTokyu", "train_type_toei_mita_express_to_tokyu"],
    ["custom.TrainType:Toei.Shinjuku.Local.Normal", "train_type_toei_shinjuku_local_normal"],
    ["custom.TrainType:Toei.Shinjuku.Express.Normal", "train_type_toei_shinjuku_express_normal"],
    ["custom.TrainType:Toei.Oedo.Local.Normal", "train_type_toei_oedo_local_normal"],
    ["custom.TrainType:Undefined", "train_type_undefined"]
  ]

  train_types_and_color_basenames.each do | same_as , color_basename |
    t = ::Train::Type::Info.find_by( same_as: same_as )
    it "(#{ same_as }) is present" do
      expect(t).to be_present
    end
    it "(#{ same_as }) has method 'css_class'" do
      expect( t.color_basename ).to eq( color_basename )
    end

  end

end
