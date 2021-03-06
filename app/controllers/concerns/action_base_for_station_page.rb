# 各駅の情報を扱う controller で共通に使用するモジュール
module ActionBaseForStationPage

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
    @title = "#{ @station_info.decorate.name_ja_actual }駅#{ base_of_station_page_title }"
  end

end
