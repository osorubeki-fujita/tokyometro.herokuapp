# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Generate::Api::Station::Info::Exit::Info < TokyoMetro::Factories::Generate::Api::Station::Info::Common::Info

  private

  def self.instance_class
    exit_info_class
  end

end