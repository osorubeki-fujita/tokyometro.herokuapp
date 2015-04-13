class TokyoMetro::App::Renderer::Concern::Header::Title::MetaClass < TokyoMetro::App::Renderer::Concern::Header::MetaClass

  def initialize(
    request , text_ja , text_en ,
    domain_id_name: nil ,
    additional_content: nil
  )
    super( request , text_ja , text_en ,
      domain_class_name: :common ,
      domain_id_name: domain_id_name ,
      additional_content: additional_content
    )
  end

end