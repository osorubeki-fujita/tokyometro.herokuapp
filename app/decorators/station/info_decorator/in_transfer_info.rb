class Station::InfoDecorator::InTransferInfo < TokyoMetro::Factory::Decorate::AppSubDecorator

  # @note {ConnectingRailwayLineDecorator#render} から呼び出される。
  def render_connection_info_from_another_station
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ class: :another_station }
  %div{ class: :text_ja }<
    = d.render_name_ja( with_subname: false , suffix: d.object.attribute_ja )
  %div{ class: :text_en }<
    = d.render_name_en( with_subname: false , suffix: d.object.attribute_en_short.capitalize )
    HAML
  end

end
