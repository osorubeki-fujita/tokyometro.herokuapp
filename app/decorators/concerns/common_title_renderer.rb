module CommonTitleRenderer

  extend ActiveSupport::Concern

  module ClassMethods

    def render_top_title( request , text_ja: common_title_ja , text_en: common_title_en , domain_id_name: nil )
      ::TokyoMetro::App::Renderer::Concerns::Header::Title.new( request , text_ja , text_en , domain_id_name: domain_id_name ).render
    end

    def render_common_title( request , text_ja: common_title_ja , text_en: common_title_en )
      ::TokyoMetro::App::Renderer::Concerns::Header::Title::Base.new( request , text_ja , text_en ).render
    end

  end

end
