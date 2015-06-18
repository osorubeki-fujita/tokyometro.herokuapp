class OperatorDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%li{ class: [ :document_info_box_normal , :operator , this.css_class_name , :clearfix ] }
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
  %div{ class: :texts }
    = this.render_main_domain
    = this.render_button_domain
    = this.render_infos
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

  private

  def infos_to_render
    super().merge({
      "Infos from methods of object" => infos_from_methods_of_object ,
      "Infos from methods of decorator" => infos_from_methods_of_decorator
    })
  end

  def infos_from_methods_of_object
    super( :name_ja_normal , :name_en_normal )
  end

  def infos_from_methods_of_decorator
    super( :twitter_title )
  end

end
