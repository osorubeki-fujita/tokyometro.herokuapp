# 行先に関するメソッドを提供するモジュール
# @note 判定にはインスタンス変数 @terminal_station を利用する。
module TokyoMetro::Modules::Api::Info::Decision::TerminalStation

  include ::TokyoMetro::Modules::Common::Info::Decision::TerminalStation

  # 列車の行先を判定するメソッド
  # @param list_of_train_terminal_station [::Array <::String>] 判定する駅名のリスト
  # @return [Boolean]
  # @note 複数指定した場合は、指定された【いずれか】の駅を行先とする列車を取得する。
  def bound_for?( *list_of_train_terminal_station , compared: @terminal_station )
    raise if list_of_train_terminal_station.empty?
    super( *list_of_train_terminal_station , compared )
  end

  #-------- [alias]
  alias :is_bound_for? :bound_for?
  alias :is_terminating? :bound_for?
  alias :terminate? :bound_for?

end