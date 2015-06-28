require 'rails_helper'

RSpec.describe OperationDay, :type => :model do
  describe "called by class methods of TokyoMetro" do
    w = ::OperationDay.find_by( same_as: custom:OperationDay:Weekday" )
    sh = ::OperationDay.find_by( same_as: custom:OperationDay:SaturdayHoliday" )

    it "\#current_operation_day" do
      # 2015-06-28 17:00 (Sat)
      expect( ::TokyoMetro.current_operation_day ).to eq( ::Time.new( 2015, 6 , 27 , 12 , 0 , 0 ) )
    end

    it "\#current_diagram" do
      # 2015-06-28 17:00 (Sat)
      expect( ::TokyoMetro.current_diagram ).to eq( sh )
    end

    it "\#operation_day_as_of" do
      t_26 = ::Time.new( 2015, 6 , 26 , 12 , 0 , 0 )
      t_27 = ::Time.new( 2015, 6 , 27 , 12 , 0 , 0 )
      t_28 = ::Time.new( 2015, 6 , 28 , 12 , 0 , 0 )
      t_29 = ::Time.new( 2015, 6 , 29 , 12 , 0 , 0 )

      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 26 , 3 , 0 , 0 ) ).to eq( t_26 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 26 , 11 , 0 , 0 ) ).to eq( t_26 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 27 , 2 , 59 , 0 ) ).to eq( t_26 )

      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 27 , 3 , 0 , 0 ) ).to eq( t_27 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 27 , 11 , 0 , 0 ) ).to eq( t_27 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 28 , 2 , 59 , 0 ) ).to eq( t_27 )

      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 28 , 3 , 0 , 0 ) ).to eq( t_28 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 28 , 11 , 0 , 0 ) ).to eq( t_28 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 29 , 2 , 59 , 0 ) ).to eq( t_28 )

      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 29 , 3 , 0 , 0 ) ).to eq( t_29 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 29 , 11 , 0 , 0 ) ).to eq( t_29 )
      expect( ::TokyoMetro.operation_day_as_of( ::Time.new( 2015, 6 , 30 , 2 , 59 , 0 ) ).to eq( t_29 )
    end

    it "\#diagram_as_of" do
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 26 , 3 , 0 , 0 ) ).to eq(w)
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 26 , 12 , 0 , 0 ) ).to eq(w)
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 27 , 2 , 59 , 0 ) ).to eq(w)

      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 27 , 3 , 0 , 0 ) ).to eq( sh )
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 27 , 12 , 0 , 0 ) ).to eq( sh )
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 28 , 2 , 59 , 0 ) ).to eq( sh )

      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 28 , 3 , 0 , 0 ) ).to eq( sh )
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 28 , 12 , 0 , 0 ) ).to eq( sh )
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 29 , 2 , 59 , 0 ) ).to eq( sh )

      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 29 , 3 , 0 , 0 ) ).to eq(w)
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 29 , 12 , 0 , 0 ) ).to eq(w)
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 6 , 30 , 2 , 59 , 0 ) ).to eq(w)

      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 7 , 20 , 3 , 0 , 0 ) ).to eq( sh )
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 7 , 20 , 12 , 0 , 0 ) ).to eq( sh )
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 7 , 21 , 2 , 59 , 0 ) ).to eq( sh )

      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 7 , 21 , 3 , 0 , 0 ) ).to eq(w)
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 7 , 21 , 12 , 0 , 0 ) ).to eq(w)
      expect( ::TokyoMetro.diagram_as_of( ::Time.new( 2015, 7 , 22 , 2 , 59 , 0 ) ).to eq(w)
    end
  end
  
end
