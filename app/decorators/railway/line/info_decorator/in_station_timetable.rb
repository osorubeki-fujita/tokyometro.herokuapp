class Railway::Line::InfoDecorator::InStationTimetable < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render_header
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :railway_line }<
  %span{ class: :text_ja }<
    = this.object.name_ja
  %span{ class: :text_en }<
    = this.object.name_en
    HAML
  end

end
