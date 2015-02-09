# 処理時間を計測・表示するメソッドを提供するモジュール
module ForRails::CommonModules::CalcTime

  private

  # 処理時間を表示するメソッド
  # @param time_begin [Time] 処理の開始時間
  # @param time_end [Time or nil] 処理の終了時間
  # @return [Float]
  def calc_time( time_begin , time_end = nil )
    if time_end.nil?
      time_end = ::Time.now
    end
    unless time_end.kind_of?( ::Time )
      raise "Error"
    end
    ( ( time_end - time_begin ) * 100 ).round * 1.0 / 100
  end

end