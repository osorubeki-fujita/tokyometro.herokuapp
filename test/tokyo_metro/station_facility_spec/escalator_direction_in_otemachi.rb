#-------- odpt.StationFacility:TokyoMetro.Chiyoda.Otemachi.Outside.Escalator.1（エスカレーターの方向）
def escalator_direction_in_otemachi
  invalid_barrier_free_info_name = "odpt.StationFacility:TokyoMetro.Chiyoda.Otemachi.Outside.Escalator.1"
  proc_for_searching = Proc.new { | barrier_free_info | barrier_free_info.same_as == invalid_barrier_free_info_name }

  barrier_free_info = ::TokyoMetro::Api.station_facilities.find { | info | info.barrier_free_facilities.any?( &proc_for_searching ) }.barrier_free_facilities.find( &proc_for_searching )

  describe TokyoMetro::Api::StationFacility::Info , "after processing invalid info \"#{ invalid_barrier_free_info_name }\"" do
    before do
    end

    it "has the length 1." do
      expect( barrier_free_info.service_detail.length ).to eq(1)
    end

    it "is operated to upper side." do
      expect( barrier_free_info.service_detail.first.direction ).to be_up
    end

    it "is operated to upper side." do
      expect( barrier_free_info.service_detail.first.direction ).not_to be_down
    end
  end

end