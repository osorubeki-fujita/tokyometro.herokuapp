# 東京メトロの情報のうち、変化のない（or 非常に少ない）ものを扱うクラス・インスタンスに対して組み込むメソッドを提供するモジュールを格納する名前空間
module TokyoMetro::StaticDataModules
end

#-------- 上位空間に組み込み
# static_data_modules/to_factory.rb

#-------- Info に組み込み

#---- Instance Method
# static_data_modules/get_name.rb
# static_data_modules/get_color_info.rb
# static_data_modules/get_bg_color_info.rb

#---- Class Method
# static_data_modules/generate_from_hash_set_variable.rb

#-------- Hash に組み込み
# static_data_modules/hash.rb