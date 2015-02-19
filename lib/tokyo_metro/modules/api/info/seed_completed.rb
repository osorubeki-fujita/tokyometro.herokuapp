# データベースへの流し込みが終了したか否かに関するメソッドを提供するモジュール
module TokyoMetro::Modules::Api::Info::SeedCompleted

  # @!group データベース関連

  # データベースへの流し込みが終了したか否かを判定するメソッド
  # @return [Boolean]
  def seed_completed?
    @seed_completed
  end

  # データベースへの流し込みが終了したことを設定するメソッド
  # @return [self]
  # @note 破壊的メソッド
  def seed_completed!
    @seed_completed = true
    return self
  end

  # @!endgroup

end