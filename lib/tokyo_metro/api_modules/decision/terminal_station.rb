# 行先に関するメソッドを提供するモジュール
# @note 判定にはインスタンス変数 @terminal_station を利用する。
module TokyoMetro::ApiModules::Decision::TerminalStation

  include ::TokyoMetro::CommonModules::Decision::TerminalStation

  def bound_for?( *list_of_train_terminal_station )
    super( list_of_train_terminal_station , @terminal_station )
  end

  private

  def is_terminating?( regexp_or_string )
    super( regexp_or_string , @terminal_station )
  end

end