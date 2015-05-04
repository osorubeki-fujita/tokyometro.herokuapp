require 'spec_helper'

describe Station::InfoDecorator do
  kojimachi = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Yurakucho.Kojimachi" ).decorate
  it "has a method \'name_ja\'." do
    expect( kojimachi.decorate.name_ja ).to eq( "麴町" )
  end
end