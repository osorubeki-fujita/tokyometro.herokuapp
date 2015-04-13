# 日付・時刻を扱うクラス Time に機能を追加するモジュール
module ForRails::ExtendBuiltinLibraries::TimeModule

  def to_time_hm_array
    [ self.hour , self.min ]
  end

  def to_strf_normal_ja
    strftime( "%Y年%m月%d日 %H:%M:%S" )
  end

  def to_strf_normal_en
    strftime( "%Y-%m-%d %H:%M:%S %z" )
  end

end