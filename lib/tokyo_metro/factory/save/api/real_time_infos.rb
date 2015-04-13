# リアルタイムな情報（列車運行情報、列車ロケーション情報）を定期的に取得し保存するメソッド
module TokyoMetro::Factory::Save::Api::RealtimeInfos

  # ループの開始
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @return [nil]
  def self.begin_loop( http_client = ::HTTPClient.new , sleeping_time: 30 )
    # loop 開始
    loop do
      #-------- 列車運行情報
      TokyoMetro::Api::TrainInformation.save_datas_of_each_group( http_client , file_type: :json )
      sleep(1)

      #-------- 列車ロケーション情報
      TokyoMetro::Api::TrainLocation.save_datas_of_all_railway_lines( http_client , file_type: :json )

      # clean memory
      system( "start empty.exe *" )

      puts "\n" * 3
      puts "Now Sleeping..."
      puts sleeping_time.to_s.rjust( sleeping_time ) + " (sec)"
      i = 0
      while i < sleeping_time
        sleep(1)
        i += 1
        print "*"
      end
      puts "\n" * 3
    end
    # loop 終了

    return nil
  end

end