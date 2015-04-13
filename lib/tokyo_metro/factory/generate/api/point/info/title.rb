class TokyoMetro::Factory::Generate::Api::Point::Info::Title < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  def self.instance_class
    title_class
  end

  private

  def variables
    set_variables
    set_station_name
    [ @station_name , @code , @additional_info , @elevator , @closed ]
  end

  def set_variables
    if /\A(.+?)(?:出入口)+\Z/ === @string
      @station_name = $1
    elsif /\A(.+?)出入口(.+)\Z/ === @string
      @station_name = $1
      @code = $2
      set_variables_in_code
    else
      raise "Error"
    end
   end

  def set_variables_in_code
    if /\A(.+)[(（](.+)[）)]\Z/ === @code
      @code = $1
      @additional_info = $2
    end

    elevator_regexp = /\Aエレベーター?\Z/

    if elevator_regexp === @code
      @elevator = true
      @code = nil
    elsif elevator_regexp === @additional_info
      @elevator = true
      @additional_info = nil

    elsif @additional_info == "閉"
      @closed = true
      @additional_info = nil
    end
  end

  def set_station_name
    case @station_name
    when "明治神宮前"
      @station_name = "明治神宮前〈原宿〉"
    when "押上"
      @station_name = "押上〈スカイツリー前〉"
    end
  end

end