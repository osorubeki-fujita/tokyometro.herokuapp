# 駅の出入口の名称を扱うクラス
class TokyoMetro::Api::Point::Info::Title

  include ::TokyoMetro::ClassNameLibrary::Api::Point
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info

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
    if self.blank?
      @station_name
    else
      [ @station_name , @code ].join( " " )
    end
  end

  private :to_s_sub_1

  def self.factory_for_this_class
    factory_for_generating_title_from_hash
  end

end