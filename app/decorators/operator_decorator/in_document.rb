class OperatorDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render
    h_locals = {
      this: self ,
      infos: infos_to_render
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%li{ class: [ :document_info_box_normal , :operator , this.css_class_name , :clearfix ] }
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
  %div{ class: :texts }
    = this.render_main_domain
    = this.render_button_domain
    %ul{ class: [ :sub_infos , :clearfix ] }
      - infos.each do | title , attrs |
        %li{ class: [ :title , :text_en ] }<
          = title
        %dl{ class: :clearfix }
          - attrs.each do | info_attr |
            - if info_attr.instance_of?( ::String ) or info_attr.instance_of?( ::Symbol )
              - info = this.send( info_attr )
            - elsif info_attr.instance_of?( ::Proc )
              - info = info_attr.call( this )
            - if info.present?
              %dt{ class: [ :attr_title , :text_en ] }<
                = info_attr.to_s + " :"
              %dd<
                = info
    HAML
  end

  def render_main_domain
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :main , :clearfix ] }
  %div{ class: :operator_name }
    = this.render_name_ja
    = this.render_name_en
  = this.render_color_info
    HAML
  end

  def render_name_ja
    render_name(
      ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja ,
      name_ja_to_haml ,
      :text_ja
    )
  end

  def render_name_en
    render_name(
      ::PositiveStringSupport::RegexpLibrary.regexp_for_quotation ,
      name_en_to_haml ,
      :text_en
    )
  end

  def render_color_info
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :color_info }
  %div{ class: :web_color }<
    = this.color
  - if this.color.present?
    %div{ class: :rgb_color }<
      = this.color.to_rgb_color_in_parentheses
    HAML
  end

  def render_button_domain
    h.content_tag( :div , '' , class: [ :button_area , :clearfix ] )
  end

  private
  
  def infos_to_render
    {
      "Attribute names of object" => attribute_names_of_object ,
      "Methods of object" => methods_of_object ,
      "Methods of decorator" => methods_of_decorator
    }
  end

  def attribute_names_of_object
    object.class.attribute_names
  end

  def methods_of_object
    [ :name_ja_normal , :name_en_normal ]
  end

  def methods_of_decorator
    [ :twitter_title ]
  end

  def render_name( regexp , name_str , p_class )
    _h_locals = {
      this: self ,
      regexp: regexp ,
      name_str: name_str ,
      p_class: p_class
    }
    h.render inline: <<-HAML , type: :haml , locals: _h_locals
%p{ class: p_class }<
  - if regexp =~ name_str
    - out_of_parentheses = name_str.gsub( regexp , "" )
    - in_parentheses =  $1
    = out_of_parentheses
    %span{ class: :sub }<
      = in_parentheses
  - else
    = name_str
    HAML
  end

end
