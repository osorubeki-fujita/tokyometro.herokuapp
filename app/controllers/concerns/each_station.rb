# 各駅の情報を扱う controller で共通に使用するモジュール
# @version 2014.11.27.13.47
module EachStation

  extend ActiveSupport::Concern

  included do

    # メソッドの動的な定義
    # @note 各駅の名称（英語名を underscore 形式に変換したもの）をメソッド名とし、
    #  each_station( 日本語名 ) を呼び出すように定義する。
    ::TokyoMetro.station_dictionary.each do | name_en , name_ja |
      eval( "def #{name_en.underscore} ; each_station( \"#{name_ja}\" ) \; end " )
    end

    private

    # 各駅の情報を呼び出すためのメソッド
    # @note 各駅共通のロジック
    # @param title_base [String] ページタイトルの共通部分
    # @param controller [String or Symbol] コントローラーの名称（render するファイルの設定に用いる）
    # @param station_name [String] 駅名（日本語）
    # @param layout [String or Symbol] 使用するレイアウトの名称
    def each_station_sub( title_base , controller , station_name , layout: :application )
      @station = ::Station.select_tokyo_metro.find_by_name_ja( station_name )
      @title = "#{ station_name.station_name_in_title }#{title_base}"
      if block_given?
        yield
      end
      render( "#{ controller.to_s }/each_station" , layout: layout.to_s )
    end

  end

end