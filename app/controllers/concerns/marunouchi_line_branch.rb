module MarunouchiLineBranch

  extend ActiveSupport::Concern

  included do

    def marunouchi_line
      each_railway_line( "M" , "m" )
    end

  end

end