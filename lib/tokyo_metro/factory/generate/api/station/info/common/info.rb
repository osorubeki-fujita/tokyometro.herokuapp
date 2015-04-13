# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::Station::Info::Common::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::Station

  private

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    [ @string ]
  end

end