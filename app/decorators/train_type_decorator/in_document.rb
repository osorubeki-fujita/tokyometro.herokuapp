class TrainTypeDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  include ::TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument::ColorInfo

  # @!group Main methods

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , number: object.id }
%li{ class: [ :document_info_box , :clearfix ] }
  %div{ class: [ :number , :text_en ] }<
    = number
  %div{ class: [ :main , :clearfix ] }<
    = this.render_name_box
    = this.render_name
    = this.render_color_infos
  = this.render_infos
    HAML
  end

  # @!group Sub public methods

  def render_name_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self , css_class_names: [ :train_type , @decorator.css_class_name ].flatten }
%div{ class: css_class_names }
  = this.train_type_in_api.decorate.render_name_in_box
    HAML
  end

  def render_name
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :train_type_name }
  = this.train_type_in_api.decorate.render_name_in_box
  %p{ class: [ :text_en , :same_as ] }<
    = this.same_as
  = this.render_note
    HAML
  end

  def render_color_infos
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :color_infos , :clearfix ] }
  - [ this.object.bgcolor, this.object.color ].each do | color |
    = this.render_color_info( color )
    HAML
  end

  def render_note
    if note.present?
      regexp = /(（.+）)\Z/
      if regexp =~ object.note
        note_main = object.note.gsub( regexp , "" )
        note_sub = $1
      else
        note_main = note
        note_sub = nil
      end
      h.render inline: <<-HAML , type: :haml , locals: { note_main: note_main , note_sub: note_sub }
%p{ class: [ :note , :text_ja ] }<
  = note_main
- if note_sub.present?
  %p{ class: [ :note_sub , :text_ja ] }<
    = note_sub
      HAML
    end
  end

  # @!endgroup

  private

  def infos_to_render
    super().merge({
      "Infos from Db columns of train_type_in_api object" => infos_from_db_columns_of_train_type_in_api_object ,
      "Infos from methods of object" => infos_from_methods_of_object ,
      "Infos from methods of decorator" => infos_from_methods_of_decorator
    })
  end

  def infos_from_db_columns_of_train_type_in_api_object
    infors_from_db_columns_of( object.train_type_in_api )
  end

  def infos_from_methods_of_object
    super( :normal? , :colored? )
  end

  def infos_from_methods_of_decorator
    super( :css_class_name )
  end

end
