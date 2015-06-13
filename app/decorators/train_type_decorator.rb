class TrainTypeDecorator < Draper::Decorator
  delegate_all

  def css_class_name
    object.same_as.gsub( regexp_for_css_class_in_document , "" ).gsub( /\./ , "_" ).underscore
  end

  def render_in_station_timetable
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :train_type }<>
  = this.train_type_in_api.name_ja
    HAML
  end

  def render_in_train_location
    div_classes = [ :train_type , :clearfix , css_class_name , :text ].flatten
    h.render inline: <<-HAML , type: :haml , locals: { this: self , div_classes: div_classes }
%div{ class: div_classes }<
  = this.train_type_in_api.decorate.render_in_train_location
    HAML
  end

=begin

  def render_in_train_location
    div_classes = [ :train_type , :clearfix , css_class_name , :text_ja ].flatten
    h.render inline: <<-HAML , type: :haml , locals: { this: self , div_classes: div_classes }
%p{ class: div_classes }<
  = this.train_type_in_api.decorate.render_in_train_location
    HAML
  end

=end

  def render_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :document_info_box_wide }
  = this.render_name_box
  = this.render_name_in_document_info_box
  = this.render_color_infos_in_document_info_box
    HAML
  end

  def render_name_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self , class_name: css_class_name }
%div{ class: class_name }
  = this.train_type_in_api.decorate.render_name_in_box
    HAML
  end

  def render_name_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :train_type_name }
  = this.train_type_in_api.decorate.render_name_in_document_info_box
  = this.render_same_as_in_document_info_box
  = this.render_note_in_document_info_box
    HAML
  end

  def render_name_box_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { this: self , class_name: class_name_of_name_box }
%div{ class: [ this.railway_line.css_class_name , :train_type_outer ] }
  %div{ class: class_name }
    = this.train_type_in_api.decorate.render_name_in_travel_time_info
    HAML
  end

  def render_same_as_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :same_as }<
  = this.same_as
    HAML
  end

  def render_note_in_document_info_box
    if note.present?
      regexp = /(（.+）)\Z/
      h.render inline: <<-HAML , type: :haml , locals: { this: self , regexp: regexp }
- if regexp =~ this.note
  %div{ class: :note }<
    = this.note.gsub( regexp , "" )
  %span{ class: :note_sub }<
    = $1
- else
  %div{ class: :note }<
    = this.note
      HAML
    end
  end

  def render_color_infos_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :color_infos }
  %div{ class: :color_info }
    %div{ class: :web_color }<
      = this.bgcolor
    %div{ class: :rgb_color }<
      = this.bgcolor.to_rgb_color_in_parentheses
  %div{ class: :color_info }
    %div{ class: :web_color }<
      = this.color
    %div{ class: :rgb_color }<
      = this.color.to_rgb_color_in_parentheses
    HAML
  end

  private

  def regexp_for_css_class_in_document
    /\Acustom\.TrainType\:(?:[a-zA-Z]+)\.(?:[a-zA-Z]+)\./
  end

  def class_name_of_name_box
    ary = [ css_class_name ]
    unless color == "\#333333"
      ary << :train_type_displayed
    else
      ary << :train_type_displayed_black
    end
    ary
  end

end