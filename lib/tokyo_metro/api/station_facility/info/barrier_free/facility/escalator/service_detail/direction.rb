# エスカレータの方向を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

  def initialize( up , down )
    @up = up
    @down = down
  end

  # 上り方向のエスカレータが存在するか否か
  # @return [Boolean]
  attr_reader :up

  # 下り方向のエスカレータが存在するか否か
  # @return [Boolean]
  attr_reader :down

  def self.factory_for_this_class
    factory_for_generating_barrier_free_escalator_service_detail_direction
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_escalator_service_detail_direction
  end

end