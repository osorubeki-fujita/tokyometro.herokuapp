# 処理時間を計測・表示するメソッドを提供するモジュール
module ForRails::CommonModules::InspectProcessTime

  private

  # 処理時間を表示するメソッド
  # @param content [String] 処理の内容
  # @param time_begin [Time] 処理の開始時間
  # @return [nil]
  def inspect_process_time( content , time_begin )
    time_end = Time.now
    puts "#{content}: #{ ( ( ( time_end - time_begin ) * 100 ).to_i ) / 100.0 } sec"
  end

end