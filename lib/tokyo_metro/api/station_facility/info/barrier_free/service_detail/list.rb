# 施設の詳細情報の配列を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::List < TokyoMetro::Api::MetaClass::Fundamental::List

  # インスタンスの情報を文字列に変換するメソッド
  # @return [String]
  def to_s
    self.map { | info | info.to_s }.join("／")
  end

  alias :to_strf :to_s

  # インスタンスの情報をDBに流し込むメソッド
  # @return [nil]
  def seed( bf_instance_id )
    self.each do | service_detail |
      service_detail.seed( bf_instance_id )
    end
    return nil
  end

end