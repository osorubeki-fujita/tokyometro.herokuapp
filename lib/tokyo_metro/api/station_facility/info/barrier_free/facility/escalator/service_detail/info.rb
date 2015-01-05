# エスカレータの詳細情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator
  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash

  def initialize( service_start_time , service_end_time , operation_day , direction )
    super( service_start_time , service_end_time , operation_day )
    @direction = direction
  end

  # @return [Direction] エスカレータの方向
  attr_reader :direction

  def to_s( indent = 0 )
    if @direction.to_s == ""
      super + " " + "☆☆☆☆☆☆☆☆"
    else
      super + " " + @direction.to_s
    end
  end

  def to_a
    super + [ @direction ]
  end

  # エスカレーターの方向の情報を返すメソッド
  # @return [::Array <Boolean>]
  def escalator_directions
    @direction.to_a
  end

  private

  alias :seed__escalator_directions :escalator_directions

end