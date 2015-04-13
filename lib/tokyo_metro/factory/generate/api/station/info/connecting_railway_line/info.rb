# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::Station::Info::ConnectingRailwayLine::Info < TokyoMetro::Factory::Generate::Api::Station::Info::Common::Info

  private

  def self.instance_class
    connecting_railway_line_info_class
  end

end