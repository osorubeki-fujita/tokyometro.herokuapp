# 各駅の情報を扱う controller で共通に使用するモジュール
module ActionBaseForStationPage

  extend ActiveSupport::Concern

  included do

    def action_base_for_station_page( controller , layout: :application )
      set_station_info_by_params

      if block_given?
        yield
      end
      set_title_of_station_page

      render( "#{ controller }/each_station" , layout: layout.to_s )
    end

    private

    def set_station_info_by_params
      s = ::Station::Info.select_tokyo_metro.find_by( name_in_system: params[ :station ].camelize )
      if s.nil?
        raise "Error"
      end
      @station_info = s
    end

    def set_title_of_station_page
      @title = "#{ @station_info.name_ja.station_name_in_title }駅#{ base_of_station_page_title }"
    end

    def railway_line_by_params( branch_railway_line: nil )
      raise "Error" unless [ :exclude , :main_and_branch , :convert_to_main , :no_process ].include?( branch_railway_line )

      if params[ :railway_line ].blank?
        r = @station_info.railway_line
      else
        railway_line_name_base_by_params = params[ :railway_line ].gsub( /_line\Z/ , "" )
        railway_line_name_same_as = "odpt.Railway:TokyoMetro.#{ railway_line_name_base_by_params.camelize }"
        r = ::RailwayLine.tokyo_metro.find_by( same_as: railway_line_name_same_as )
        if r.blank?
          raise "Error: \"#{ railway_line_name_same_as }\" is not valid as a railway line name."
        end
      end

      unless r.is_branch_railway_line? or r.has_branch_railway_line?
        return r
      end

      if r.is_branch_railway_line?
        case branch_railway_line
        when :exclude
          nil
        when :main_and_branch
          ::RailwayLine.where( id: [ r.id , r.main_railway_line_id ].sort )
        when :convert_to_main
          r.main_railway_line
        when :no_process
          r
        end

      elsif r.has_branch_railway_line?
        case branch_railway_line
        when :exclude , :no_process , :convert_to_main
          r
        when :main_and_branch
          ::RailwayLine.where( id: [ r.id , r.branch_railway_line_id ].sort )
        end
      end
    end

  end

end