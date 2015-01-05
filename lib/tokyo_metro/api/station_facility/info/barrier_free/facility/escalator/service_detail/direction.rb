# エスカレータの方向を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction < ::Struct.new( :up , :down )

  # 文字列をもとにインスタンスを生成するメソッド
  # @param str [String] インスタンスのもとになる文字列
  # @return [Direction]
  def self.generate_from_string( str )
    case str
    when "上り・下り"
      self.new( true , true )
    when "上り"
      self.new( true , false )
    when "下り"
      self.new( false , true )
    #when nil
      #""
    else
      raise "Error: #{str.to_s} (Class: #{str.class.name}) is not valid."
    end
  end

  # @!group 方向の判定

  # 上り方向のエスカレータが存在するか否かを判定するメソッド
  # @return [Boolean]
  def up
    self[ :up ]
  end

  # 下り方向のエスカレータが存在するか否かを判定するメソッド
  # @return [Boolean]
  def down
    self[ :down ]
  end

  alias :up? :up
  alias :down? :down

  def not_up?
    !( up? )
  end

  def not_down?
    !( down? )
  end

  # 両方向にエスカレータが存在するか否かを判定するメソッド
  # @return [Boolean]
  def both?
    self.up? and self.down?
  end

  # @!group 情報の取得

  # 方向の情報を文字列に変換するメソッド
  # @return [String]
  def to_s
    if self.both?
      "上り・下り"
    elsif self.up?
      "上り"
    elsif self.down?
      "下り"
    else
      raise "Error"
    end
  end

  def to_a
    [ self.up , self.down ]
  end

  # @!endgroup

end