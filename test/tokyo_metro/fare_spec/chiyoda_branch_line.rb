def chiyoda_branch_line
  from_kita_ayase = ::TokyoMetro::Api.fares.select { | item | /KitaAyase\Z/ === item.from_station }
  to_kita_ayase = ::TokyoMetro::Api.fares.select { | item | /KitaAyase\Z/ === item.to_station }

  from_ayase = ::TokyoMetro::Api.fares.select { | item | /Chiyoda\.Ayase\Z/ === item.from_station }
  to_ayase = ::TokyoMetro::Api.fares.select { | item | /Chiyoda\.Ayase\Z/ === item.to_station }

  kita_ayase_set = [
    [ from_kita_ayase , :from_station ] , # 北綾瀬から
    [ to_kita_ayase , :to_station ] # 北綾瀬へ
  ]

  ayase_set = [
    [ from_ayase , :from_station ] , # 綾瀬から
    [ to_ayase , :to_station ] # 綾瀬へ
  ]


  kita_ayase_set.each do | ary , method_name |
    ary.each do | item |
      describe ::TokyoMetro::Api::Fare::Info , "after converting station name of Kita-ayase" do
        it "(#{method_name} of #{item.same_as}) should be on Chiyoda Branch Line." do
          expect( item.send( method_name ) ).to eq( "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )
          expect( item.same_as ).to match( /ChiyodaBranch\.KitaAyase/ )
        end
        it "(#{method_name} of #{item.same_as}) should not be on Chiyoda Line." do
          expect( item.send( method_name ) ).not_to match( /Chiyoda\.KitaAyase\Z/ )
          expect( item.same_as ).not_to match( /Chiyoda\.KitaAyase/ )
        end
      end
    end
  end

  ayase_set.each do | ary , method_name |
    ary.each do | item |
      same_as_for_chiyoda_branch = item.same_as.gsub( /Chiyoda(?=\.Ayase)/ , "ChiyodaBranch" )
      station_name_for_chiyoda_branch = item.send( method_name ).gsub( /Chiyoda(?=\.Ayase)/ , "ChiyodaBranch" )

      fare_of_ayase_branch = ::TokyoMetro::Api.fares.find { | item | item.same_as == same_as_for_chiyoda_branch }

      describe ::TokyoMetro::Api::Fare::Info , "after adding infos related to Ayase on Chiyoda Branch Line" do
        it "(#{method_name} of #{item.same_as}) should be on Chiyoda Line." do
          expect( item.send( method_name ) ).to eq( "odpt.Station:TokyoMetro.Chiyoda.Ayase" )
          expect( item.same_as ).to match( /Chiyoda\.Ayase/ )
        end
        it "(#{method_name} of #{same_as_for_chiyoda_branch}) should exist." do
          expect( fare_of_ayase_branch ).to be_present
          expect( fare_of_ayase_branch.send( method_name ) ).to eq( station_name_for_chiyoda_branch )
        end
      end

    end
  end

end