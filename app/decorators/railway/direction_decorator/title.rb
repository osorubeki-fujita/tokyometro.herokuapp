class Railway::DirectionDecorator::Title < TokyoMetro::Factory::Decorate::SubDecorator

  def render_in_train_location
    render_simply
  end

  private

  def render_simply
    object.station_info.decorate.as_direction_info.render_title
  end

end
