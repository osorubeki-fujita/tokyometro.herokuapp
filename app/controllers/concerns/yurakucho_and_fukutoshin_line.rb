module YurakuchoAndFukutoshinLine

  extend ActiveSupport::Concern

  included do

    def yurakucho_and_fukutoshin_line
      each_railway_line( "odpt.Railway:TokyoMetro.Yurakucho" , "odpt.Railway:TokyoMetro.Fukutoshin" )
    end

  end

end