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
    = this.render_color_info( colors )
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

end

__END__

  def infos_to_render
    super().merge({
      "Infos from Db columns of operator object" => infos_from_db_columns_of_operator_object ,
      "Infos from methods of operator object" => infos_from_methods_of_operator_object ,
      "Infos from methods of operator decorator" => infos_from_methods_of_operator_decorator
    })
  end

  def infos_from_db_columns_of_operator_object
    infors_from_db_columns_of( object.operator )
  end

  def infos_from_methods_of_operator_object
    infos_from_methods_of( object.operator , :name_ja_normal , :name_en_normal )
  end

  def infos_from_methods_of_operator_decorator
    infos_from_methods_of( object.operator.decorate , :twitter_title )
  end

end
