require_relative 'fundamental_settings.rb'

::TokyoMetro.set_api_constants( { station_facility: true } )

#-------- 中野新橋駅 トイレ設置場所
# @note 誤：odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Outside.Toilet.1
# @note 正：odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Inside.Toilet.1

def located_area_of_toilet_in_nakano_shimbashi

  valid_barrier_free_info_name = "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Inside.Toilet.1"
  invalid_barrier_free_info_name = "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Outside.Toilet.1"
  
  proc_for_searching_barrier_free_facility = Proc.new { | barrier_free_info |
    barrier_free_info.same_as == valid_barrier_free_info_name
  }
  
  describe ::TokyoMetro::Api::StationFacility::List , "after processing invalid info \"#{ valid_barrier_free_info_name }\"" do
    before do
      info = ::TokyoMetro::Api.station_facilities.find { | info |
        info.barrier_free_facilities.any?( &proc_for_searching_barrier_free_facility )
      }
      @barrier_free_info = info.barrier_free_facilities.find( &proc_for_searching_barrier_free_facility )
      @valid_platform_infos = info.platform_infos.select { | info |
        info.barrier_free_facilities.present? and info.barrier_free_facilities.include?( valid_barrier_free_info_name )
      }
      @invalid_platform_infos = info.platform_infos.select { | info |
        info.barrier_free_facilities.present? and info.barrier_free_facilities.include?( invalid_barrier_free_info_name )
      }
    end
  
    it "should be located in inside area." do
      expect( @barrier_free_info ).to be_outside
    end
    it "should be present." do
      expect( @valid_platform_infos ).to be_present
    end
    it "should not exist." do
      expect( @invalid_platform_infos ).to be_blank
    end
  
    after do
      @barrier_free_info = nil
      @valid_platform_infos = nil
      @invalid_platform_infos = nil
    end
  end

end

located_area_of_toilet_in_nakano_shimbashi