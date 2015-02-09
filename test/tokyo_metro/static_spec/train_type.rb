def train_type
  train_type_sub( ::TokyoMetro::Static.train_types )
  train_type_sub( ::TokyoMetro::Static.train_types_other_operator )
end

def train_type_sub(h)
  h.each do | train_type_name , info |
  
    describe ::TokyoMetro::Static::TrainType::Custom::Main::Info do
      it "(#{train_type_name}) should contain color info." do
        expect( info.color ).not_to be_instance_of( ::Array )
        expect( info.color.instance_of?( ::TokyoMetro::Static::Color ) || info.color.instance_of?( ::TokyoMetro::Static::TrainType::Color::Info ) ).to be_truthy
      end
      it "(#{train_type_name}) should contain bgcolor info." do
        expect( info.bgcolor ).not_to be_instance_of( ::Array )
        expect( info.bgcolor.instance_of?( ::TokyoMetro::Static::Color ) || info.bgcolor.instance_of?( ::TokyoMetro::Static::TrainType::Color::Info ) ).to be_truthy
      end
    end
    
  end
end