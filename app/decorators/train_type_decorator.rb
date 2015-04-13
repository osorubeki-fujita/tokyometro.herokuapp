class TrainTypeDecorator < Draper::Decorator
  delegate_all

  def css_class_in_document
    object.same_as.gsub( regexp_for_css_class_in_document , "" ).gsub( /\./ , "_" ).underscore
  end

  def render_in_station_timetable
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :train_type }<>
  = info.train_type_in_api.name_ja
    HAML
  end

  def render_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :document_info_box_wide }
  = info.render_name_box
  = info.render_name_in_document_info_box
  = info.render_color_infos_in_document_info_box
    HAML
  end

  def render_name_box_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self , class_name: class_name_of_name_box }
%div{ class: [ info.railway_line.css_class_name , :train_type_outer ] }
  %div{ class: class_name }
    = info.train_type_in_api.decorate.render_name_in_travel_time_info
    HAML
  end

  def render_name_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self , class_name: class_name_of_name_box }
%div{ class: class_name }
  = info.train_type_in_api.decorate.render_name_in_box
    HAML
  end

  def render_name_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :train_type_name }
  = info.train_type_in_api.decorate.render_name_in_document_info_box
  = info.render_same_as_in_document_info_box
  = info.render_note_in_document_info_box
    HAML
  end

  def render_same_as_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :same_as }<
  = info.same_as
    HAML
  end

  def render_note_in_document_info_box
    if note.present?
      regexp = /(（.+）)\Z/
      h.render inline: <<-HAML , type: :haml , locals: { info: self , regexp: regexp }
- if regexp =~ info.note
  %div{ class: :note }<
    = info.note.gsub( regexp , "" )
  %span{ class: :note_sub }<
    = $1
- else
  %div{ class: :note }<
    = info.note
      HAML
    end
  end

  def render_color_infos_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :color_infos }
  %div{ class: :color_info }
    %div{ class: :web_color }<
      = info.bgcolor
    %div{ class: :rgb_color }<
      = ::ApplicationHelper.rgb_in_parentheses( info.bgcolor )
  %div{ class: :color_info }
    %div{ class: :web_color }<
      = info.color
    %div{ class: :rgb_color }<
      = ::ApplicationHelper.rgb_in_parentheses( info.color )
    HAML
  end

  private

  def regexp_for_css_class_in_document
    /\Acustom\.TrainType\:(?:[a-zA-Z]+)\.(?:[a-zA-Z]+)\./
  end

  def class_name_of_name_box
    ary = [ css_class_in_document ]
    unless color == "\#333333"
      ary << :train_type_displayed
    else
      ary << :train_type_displayed_black
    end
    ary
  end

end