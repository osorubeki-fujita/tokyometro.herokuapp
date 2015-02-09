# SCSS の fundemantal ファイルを作成・処理するための Factory Pattern Class
# @note 廃止
class TokyoMetro::Factories::Scss::Fundamental < TokyoMetro::Factories::Scss

  class << self

    private

    # SCSS ファイルの名称
    # @return [String]
    def scss_filename
      super( "fundamental" )
    end

    # CSS ファイルの名称
    # @return [String]
    def css_filename
      super( "fundamental" )
    end

  end

end