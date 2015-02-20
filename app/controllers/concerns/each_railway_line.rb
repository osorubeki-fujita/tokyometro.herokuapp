module EachRailwayLine

  extend ActiveSupport::Concern

  included do

    def ginza_line
      each_railway_line( "G" )
    end

    def marunouchi_line
      each_railway_line( "M" )
    end

    def hibiya_line
      each_railway_line( "H" )
    end

    def tozai_line
      each_railway_line( "T" )
    end

    def chiyoda_line
      each_railway_line( "C" )
    end

    def yurakucho_line
      each_railway_line( "Y" )
    end

    def hanzomon_line
      each_railway_line( "Z" )
    end

    def namboku_line
      each_railway_line( "N" )
    end

    def fukutoshin_line
      each_railway_line( "F" )
    end

    private

    def each_railway_line_sub( title_base , controller , *railway_line_name_codes , with_branch: false , layout: "application" )
      if with_branch
        @railway_lines = ::RailwayLine.tokyo_metro_including_branch.select_by_railway_line_codes( railway_line_name_codes )
      else
        @railway_lines = ::RailwayLine.tokyo_metro.select_by_railway_line_codes( railway_line_name_codes )
      end
      if @railway_lines.where( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ).present?
        @railway_lines = @railway_lines.where.not( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" )
      end

      if block_given?
        yield
      end

      class << @railway_lines
        include ForRails::RailwayLineArrayModule
      end
      @title = @railway_lines.to_railway_line_name_text_ja + " #{title_base}"
      render "#{controller}/each_railway_line" , layout: layout
    end

  end

end