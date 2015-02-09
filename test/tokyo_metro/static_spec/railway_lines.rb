def railway_lines
  ::TokyoMetro::Static.railway_lines.each do | railway_line_name , info |

    describe ::TokyoMetro::Static::RailwayLine::Info do
      it "(\'same_as\' of #{railway_line_name}) should be an instance of String." do
        expect( info.same_as ).to be_instance_of( ::String )
      end
      it "(\'name_ja\' of #{railway_line_name}) should be an instance of Array." do
        expect( info.name_ja ).to be_instance_of( ::Array )
      end
      it "(\'name_en\' of #{railway_line_name}) should be an instance of Array." do
        expect( info.name_en ).to be_instance_of( ::Array )
      end
      it "(\'index\' of #{railway_line_name}) should be a number." do
        expect( info.index ).to be_number
      end
      it "(\'operator\' of #{railway_line_name}) should be an instance of TokyoMetro::Static::Operator::Info." do
        expect( info.operator ).to be_instance_of( ::TokyoMetro::Static::Operator::Info )
      end
    end

    if info.color.present?
      describe ::TokyoMetro::Static::RailwayLine::Info do
        it "(#{railway_line_name}) should contain color info." do
          expect( info.color ).to be_instance_of( ::Array )
          # expect( info.color ).to be_instance_of( ::TokyoMetro::Static::Color )
        end
      end
    end

  end
end