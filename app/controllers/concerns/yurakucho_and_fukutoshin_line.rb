module YurakuchoAndFukutoshinLine

  extend ActiveSupport::Concern

  included do

    def yurakucho_and_fukutoshin_line
      each_railway_line( "Y" , "F" )
    end

  end

end