module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

  # @!group 方向の判定

  def only_up
    up and !( down )
  end

  def only_down
    down and !( up )
  end

  # 両方向にエスカレータが存在するか否か
  # @return [Boolean]
  def both
    up and down
  end

  [ :up , :down , :both ].each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }?
        #{ method_base_name }
      end

      def not_#{ method_base_name }?
        !( #{ method_base_name }? )
      end

      alias :is_#{ method_base_name }? :#{ method_base_name }?
      alias :is_not_#{ method_base_name }? :not_#{ method_base_name }?
    DEF
  end

  [ :up , :down ].each do | method_base_name |
    eval <<-DEF
      def only_#{ method_base_name }?
        only_#{ method_base_name }
      end

      alias :is_only_#{ method_base_name }? :only_#{ method_base_name }?
    DEF
  end

  alias :has_both_directions? :both?

  # @!group 情報の取得

  # 方向の情報を文字列に変換するメソッド
  # @return [String]
  def to_s
    if both?
      "上り・下り"
    elsif only_up?
      "上り"
    elsif only_down?
      "下り"
    else
      raise "Error"
    end
  end

  def attribute
    if both?
      :both
    elsif only_up?
      :up
    else
      :down
    end
  end

  def to_a
    [ self.up? , self.down? ]
  end

  def to_h
    { up: self.up? , down: self.down? }
  end

  # @!endgroup

end