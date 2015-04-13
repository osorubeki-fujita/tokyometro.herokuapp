class TokyoMetro::App::Renderer::Concern::Header::MetaClass < TokyoMetro::App::Renderer::MetaClass

  def initialize(
    request , text_ja , text_en ,
    domain_id_name: nil ,
    domain_class_name: nil ,
    additional_content: nil
  )
    super( request )
    @domain_class_name = domain_class_name
    @text_ja = text_ja
    @text_en = text_en
    @domain_id_name = domain_id_name
    @additional_content = additional_content
  end

  private

  def h_locals
    super.merge({
      domain_class_name: @domain_class_name ,
      text_ja: @text_ja ,
      text_en: @text_en ,

      domain_id_name: @domain_id_name ,
      additional_content: @additional_content
    })
  end

end