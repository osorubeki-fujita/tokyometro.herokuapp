# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::Station::Info::Exit::Info < TokyoMetro::Factory::Generate::Api::Station::Info::Common::Info

  private

  def self.instance_class
    exit_info_class
  end

end