# 駅の出入口の名称を扱うクラス
class TokyoMetro::Api::Point::Info::Title

  # Constructor
  def initialize( station_name , code , additional_info , elevator , closed )
    @station_name = station_name
    @code = code
    @additional_info = additional_info
    @elevator = elevator
    @closed = closed
  end
  attr_reader :station_name , :code , :additional_info , :elevator , :closed

  alias :has_elevator? :elevator
  alias :closed? :closed

  def to_s
    str_1 = to_s_sub_1
    unless @additional_info == ""
      str_1 += ( "/" + @additional_info )
    end
    if @elevator
      str_1 += "/【EV】"
    end
    if @closed
      str_1 += "/【閉】"
    end

    str_1
  end

  def to_s_sub_1
    if self.code == ""
      "#{self.station_name}"
    else
      "#{self.station_name} #{self.code}"
    end
  end
  private :to_s_sub_1

  def self.generate_from_string_in_hash( str )
    code = ""
    additional_info = ""

    elevator = false
    closed = false

    if /\A(.+?)(?:出入口)+\Z/ === str
      station_name = $1
    elsif /\A(.+?)出入口(.+)\Z/ === str
      station_name = $1
      code = $2

      if /\A(.+)[(（](.+)[）)]\Z/ === code
        code = $1
        additional_info = $2
      end

      elevator_regexp = /\Aエレベーター?\Z/
      if elevator_regexp === code
        elevator = true
        code = ""
      elsif elevator_regexp === additional_info
        elevator = true
        additional_info = ""
      elsif additional_info == "閉"
        closed = true
        additional_info = ""
      end

    else
      raise "Error: \"#{title}\" is not valid."
    end

    case station_name
    when "明治神宮前"
      station_name = "明治神宮前〈原宿〉"
    when "押上"
      station_name = "押上〈スカイツリー前〉"
    end

    self.new( station_name , code , additional_info , elevator , closed )
  end

end