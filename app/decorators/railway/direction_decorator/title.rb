class Railway::DirectionDecorator::Title < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render_in_train_location
    render_simply
  end

  private

  def render_simply
    h.render inline: <<-HAML , type: :haml , locals: h_object
- station_info_decorated = object.station_info.decorate
%div{ class: :title_of_a_railway_direction }
  %h4{ class: :text_ja }<
    = station_info_decorated.name_ja_actual + "方面"
  %h5{ class: :text_en }<
    = "for " + station_info_decorated.name_en
    HAML
  end

end
