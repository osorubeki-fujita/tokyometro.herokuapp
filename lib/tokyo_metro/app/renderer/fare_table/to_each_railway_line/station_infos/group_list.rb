class TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::StationInfos::GroupList < ::Array

  def render
    ::ActionView::Base.new.render inline: <<-HAML , type: :haml , locals: { ary: self }
- ary.each do | group_info |
  = group_info.render
    HAML
  end

end