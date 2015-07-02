class OperatorDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  include ::TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument::ColorInfo

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , number: object.id }
%li{ class: [ :document_info_box , :operator , this.css_class_name , :clearfix ] }
  %div{ class: [ :number , :text_en ] }<
    = number
  = this.render_main_domain
  = this.render_button_domain
  = this.render_infos
    HAML
  end

  def render_title
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- obj = this.object
%div{ class: :operator_name }
  %h3{ class: :text_ja }<
    = obj.name_ja
  %h4{ class: :text_en }<
    = obj.name_en
  %h4{ class: [ :text_en , :same_as ] }<
    = "same_as: " + obj.same_as
    HAML
  end

  # @!group Sub public methods

  def render_main_domain
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :main , :clearfix ] }
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
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

  # @!endgroup

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
