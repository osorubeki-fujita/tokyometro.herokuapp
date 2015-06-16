require 'rails_helper'

describe Station::InfoDecorator do
  kojimachi = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Yurakucho.Kojimachi" )
  it "has a method \'name_ja_actual\'." do
    expect( kojimachi.decorate.name_ja_actual ).to eq( "麴町" )
  end
end
