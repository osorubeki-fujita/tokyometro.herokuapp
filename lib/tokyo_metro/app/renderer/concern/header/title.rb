class TokyoMetro::App::Renderer::Concern::Header::Title < TokyoMetro::App::Renderer::Concern::Header::MetaClass

  def initialize(
    request , text_ja , text_en ,
    domain_id_name: nil ,
    domain_class_name: nil ,
    icon_name: nil , 
    icon_size: 3 ,
    additional_content: nil
  )
    super(
    request , text_ja , text_en ,
    domain_id_name: domain_id_name ,
    domain_class_name: domain_class_name , 
    additional_content: additional_content
  )

    @icon_name = icon_name
    @icon_size = icon_size
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals

- if domain_id_name.present?

  %div{ id: domain_id_name , class: domain_class_name }
    = ::TokyoMetro::App::Renderer::Concern::Header::Title::Base.new( request , text_ja , text_en ).render
    = ::TokyoMetro::App::Renderer::Concern::Header::Title::Top.new( request ).render
    - if additional_content.present?
      = additional_content.call

- else
  %div{ class: :common }
    = ::TokyoMetro::App::Renderer::Concern::Header::Title::Base.new( request , text_ja , text_en ).render
  = ::TokyoMetro::App::Renderer::Concern::Header::Title::Top.new( request ).render
  - if additional_content.present?
    = additional_content.call

    HAML
  end

  private

  def h_locals
    super.merge({
      icon_name: @icon_name ,
      icon_size: @icon_size
    })
  end

end