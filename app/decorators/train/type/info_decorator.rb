class Train::Type::InfoDecorator < Draper::Decorator
  delegate_all

  def render_in_station_timetable
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :train_type }<>
  = this.in_api.name_ja
    HAML
  end

  def render_in_train_location
    div_classes = [ :train_type , :clearfix , css_class , :text ].flatten
    h.render inline: <<-HAML , type: :haml , locals: { this: self , div_classes: div_classes }
%div{ class: div_classes }<
  = this.in_api.decorate.render_in_train_location
    HAML
  end

  def render_name_box_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { this: self , class_name: css_class }
%div{ class: [ this.railway_line_info.css_class , :train_type_outer ] }
  %div{ class: class_name }
    = this.in_api.decorate.render_name_in_travel_time_info
    HAML
  end

  def in_document
    ::Train::Type::InfoDecorator::InDocument.new( self )
  end

end
