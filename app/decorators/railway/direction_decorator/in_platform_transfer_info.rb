class Railway::DirectionDecorator::InPlatformTransferInfo < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render
    object.station_info.decorate.as_direction_info.render_precisely
  end

end
