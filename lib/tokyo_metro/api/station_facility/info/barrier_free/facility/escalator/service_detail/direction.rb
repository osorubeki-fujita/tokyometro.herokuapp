# エスカレータの方向を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::CommonModules::ToFactory::Generate::Info
  include ::TokyoMetro::CommonModules::ToFactory::Seed::Info

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

  # @!group 方向の判定

  [ :up , :down ].each do | instance_variable_name |
    eval <<-DEF
      alias :#{ instance_variable_name }? :#{ instance_variable_name }
      def not_#{ instance_variable_name }?
        !( #{ instance_variable_name }? )
      end
    DEF
  end

  # 両方向にエスカレータが存在するか否か
  # @return [Boolean]
  def both?
    up? and down?
  end

  # @!group 情報の取得

  # 方向の情報を文字列に変換するメソッド
  # @return [String]
  def to_s
    if both?
      "上り・下り"
    elsif up?
      "上り"
    elsif down?
      "下り"
    else
      raise "Error"
    end
  end

  def to_a
    [ self.up? , self.down? ]
  end

  def to_h
    { up: self.up? , down: self.down? }
  end

  # @!endgroup

  def self.factory_for_this_class
    factory_for_generating_barrier_free_escalator_service_detail_direction
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_escalator_service_detail_direction
  end

end