namespace :tokyo_metro do
  namespace :test do
    namespace :define do
    
      namespace :static do
      
        desc "定義 - 鉄道事業者"
        task :operators => :load do
          ::TokyoMetro::Static.operators.define_test
        end
        desc "定義 - 車両所有事業者"
        task :train_owners => :load do
          ::TokyoMetro::Static.train_owners.define_test
        end
        desc "定義 - 路線"
        task :railway_lines => :load do
          ::TokyoMetro::Static.railway_lines.define_test
        end
        desc "定義 - 駅（東京メトロ）"
        task :stations_in_tokyo_metro => :load do
          ::TokyoMetro::Static.stations_in_tokyo_metro.define_test
        end
        desc "定義 - 駅（すべて）"
        task :stations => :load do
          ::TokyoMetro::Static.stations.define_test
        end
        # desc "定義 - 停車駅パターン"
        # task :stopping_patterns => :load do
          # ::TokyoMetro::Static.stopping_patterns.define_test
        # end
        namespace :train_types do
          desc "定義 - 列車種別 (API)"
          task :in_api => :load do
            ::TokyoMetro::Static.train_types_in_api.define_test
          end
          desc "定義 - 列車種別（色データ）"
          task :color => :load do
            ::TokyoMetro::Static.train_types_color.define_test
          end
          desc "定義 - 列車種別（他事業者）"
          task :other_operator => :load do
            ::TokyoMetro::Static.train_types_other_operator.define_test
          end
          desc "定義 - 列車種別（デフォルト設定）"
          task :default => :load do
            ::TokyoMetro::Static.train_types_default.define_test
          end
          desc "定義 - 列車種別（メイン）"
          task :main => :load do
            ::TokyoMetro::Static.train_types.define_test
          end
        end

      end
      
    end
  end
end