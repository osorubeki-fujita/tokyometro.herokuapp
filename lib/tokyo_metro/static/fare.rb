# 東京メトロの運賃の情報を扱うモジュール
module TokyoMetro::Static::Fare

  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # 最後の運賃改定が行われた日付
  # @return [::DateTime]
  # @note 現在の運賃は、2014年4月1日改定のもの。旧運賃は2014年3月31日の終電まで適用されていたため、2014年4月1日未明（3月31日の終電後）に現運賃へ切り替えが行われたものとする。
  # @note TokyoMetro::Static::Fare.last_revision で呼び出すことができる。
  LAST_REVISION = ::DateTime.new( 2014 , 4 , 1 , ::TokyoMetro.change_date , 0 , 0 )

  # 定数 {::TokyoMetro::Static::NORMAL_FARE} を設定するメソッド
  # @note {::TokyoMetro::Static.normal_fare} で呼び出すこともできる。
  # @note {::TokyoMetro::Static::Fare::Normal.instance.current_faretable.list} は {::TokyoMetro::Static::Fare::Normal::Table::List} クラスのインスタンス
  # @return [:NORMAL_FARE]
  def self.set_constant
    ::TokyoMetro::Static.const_set( :NORMAL_FARE , self.normal_fare_class.instance.current_faretable.list )
  end

end