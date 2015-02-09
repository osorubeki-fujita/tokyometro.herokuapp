# 日付・時刻を扱うクラス Time に機能を追加するモジュール
module ForRails::ExtendBuiltinLibraries::TimeModule

  def to_time_hm_array
    [ self.hour , self.min ]
  end

end