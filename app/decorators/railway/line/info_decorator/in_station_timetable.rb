class Railway::Line::InfoDecorator::InStationTimetable < TokyoMetro::Factory::Decorate::SubDecorator

  def render_header
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ class: :railway_line }<
  %span{ class: :text_ja }<
    = this.object.name_ja
  %span{ class: :text_en }<
    = this.object.name_en
    HAML
  end

end
