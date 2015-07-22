class Railway::DirectionDecorator::InPlatformTransferInfo < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render
    h.render inline: <<-HAML , type: :haml , locals: { station_info_deccorated: object.station_info.decorate }
%div{ class: :railway_direction }
  %p{ class: :text_ja }<
    = station_info_deccorated.render_name_ja( with_subname: false , suffix: "方面" )
  %p{ class: :text_en }<
    = station_info_deccorated.render_name_en( with_subname: false , prefix: "for " )
    HAML
  end

end
