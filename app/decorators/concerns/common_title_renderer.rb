module CommonTitleRenderer

  extend ActiveSupport::Concern

  module ClassMethods

    def render_top_title( text_ja: common_title_ja , text_en: common_title_en , id: nil )
      h.render_top_title( text_ja: text_ja , text_en: common_title_en , id: id )
    end

    def render_common_title( text_ja: common_title_ja , text_en: common_title_en )
      h.render_common_title( text_ja: text_ja , text_en: text_en )
    end

  end

end