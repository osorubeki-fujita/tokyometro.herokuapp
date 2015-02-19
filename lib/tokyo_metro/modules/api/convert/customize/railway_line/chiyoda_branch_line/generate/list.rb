module TokyoMetro::Modules::Api::Convert::Customize::RailwayLine::ChiyodaBranchLine::Generate::List

  def generate( max = nil )
    ary = super( max )

    chiyoda = ary.find { | item | item.same_as == "odpt.Railway:TokyoMetro.Chiyoda" }
    return ary if chiyoda.nil?

    # 千代田線（本線）のデータを複製し、千代田線（支線）のデータを生成
    chiyoda_branch = ::Marshal.load( Marshal.dump( chiyoda ) )

    # 千代田線（本線）の station_order, travel_time から北綾瀬の情報を削除
    chiyoda.instance_eval do
      @station_order = @station_order.delete_if { | item |
        item.station == "odpt.Station:TokyoMetro.Chiyoda.KitaAyase"
      }
      @travel_time = @travel_time.delete_if { | item |
        item.between?( "odpt.Station:TokyoMetro.Chiyoda.Ayase" , "odpt.Station:TokyoMetro.Chiyoda.KitaAyase" )
      }
    end

    # 千代田線（支線）の基本情報を設定
    chiyoda_branch.instance_eval do
      @women_only_car = nil
      @dc_date = nil
      @region = nil
      @id_urn = nil
      @same_as = "odpt.Railway:TokyoMetro.ChiyodaBranch"
    end

    regexp_for_replace = ::TokyoMetro::Modules::Api::Convert::Customize::Dictionary::RegexpForReplace.chiyoda_branch_line_stations

    # 千代田線（支線）の station_order から綾瀬・北綾瀬以外の情報を削除し、駅名を変換
    chiyoda_branch.station_order.keep_if { | item |
      [ "odpt.Station:TokyoMetro.Chiyoda.KitaAyase" , "odpt.Station:TokyoMetro.Chiyoda.Ayase" ].include?( item.station )
    }

    chiyoda_branch.station_order.each_with_index do | item , i |
      item.instance_eval do
        @station = @station.gsub( regexp_for_replace , "ChiyodaBranch" )
        @index = i
      end
    end

    # 千代田線（支線）の travel_time から綾瀬・北綾瀬以外の情報を削除し、駅名を変換
    chiyoda_branch.travel_time.keep_if { | item |
      item.between?( "odpt.Station:TokyoMetro.Chiyoda.Ayase" , "odpt.Station:TokyoMetro.Chiyoda.KitaAyase" )
    }

    chiyoda_branch.travel_time.each do | item |
      item.instance_eval do
        @from_station , @to_station = [ @from_station , @to_station ].map { | item |
          item.gsub( regexp_for_replace , "ChiyodaBranch" )
        }
      end
    end

    # 路線情報の配列に千代田線（支線）のインスタンスを追加
    ary << chiyoda_branch

    return ary
  end

end