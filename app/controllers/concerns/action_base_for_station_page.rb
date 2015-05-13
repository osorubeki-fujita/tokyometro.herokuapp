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

__END__


    # メソッドの動的な定義
    # @note 各駅の名称（英語名を underscore 形式に変換したもの）をメソッド名とし、
    #  each_station( 日本語名 ) を呼び出すように定義する。
    if ::Station::Info.count > 0
      ::Station::Info.tokyo_metro.pluck( :name_in_system , :same_as ).each do | name_in_system , same_as |
        eval <<-DEF
          def #{ name_in_system.underscore }
            each_station( \"#{ same_as }\" )
          end
        DEF
      end
    end

    private

    # 各駅の情報を呼び出すためのメソッド
    # @note 各駅共通のロジック
    # @param title_base [String] ページタイトルの共通部分
    # @param controller_name [String or Symbol] コントローラーの名称（render するファイルの設定に用いる）
    # @param station_same_as [String] 駅名（日本語）
    # @param layout [String or Symbol] 使用するレイアウトの名称
    def each_station_sub( title_base , controller_name , station_info_same_as , layout: :application )
      @station_info = ::Station::Info.select_tokyo_metro.find_by( same_as: station_info_same_as )
      @title = "#{ @station_info.decorate.name_ja_actual }#{title_base}"
      if block_given?
        yield
      end
      render( "#{ controller_name }/each_station" , layout: layout.to_s )
    end