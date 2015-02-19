# API から提供されるデータのメタクラス
class TokyoMetro::Api::MetaClass::Fundamental

  include ::TokyoMetro::Modules::Api::Common::NotRealTime
  include ::TokyoMetro::Modules::Api::Common::DbDirname

  # @!group Factory Pattern のクラスの情報

  # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
  # @return [Const (class)]
  # @raise [RuntimeError] サブクラスで定義するため、このクラスでは例外が発生するようにしている。
  def self.factory_for_generating_from_saved_file
    raise "The class method \"#{ __method__ }\" is not defined in this class \"#{ self.name }\"."
  end

  # @!endgroup

end