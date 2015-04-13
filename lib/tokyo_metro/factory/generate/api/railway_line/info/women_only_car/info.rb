# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::RailwayLine::Info::WomenOnlyCar::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  def variables
    ary_of_keys_1 = [ "odpt:fromStation" , "odpt:toStation" , "odpt:operationDay" ]
    ary_of_keys_2 = [ "odpt:availableTimeFrom" , "odpt:availableTimeUntil" ]
    ary_of_keys_3 = [ "odpt:carComposition" , "odpt:carNumber" ]
    time_now = Time.now

    ary = ::Array.new
    ary += ary_of_keys_1.map { | key | @hash [ key] }
    ary += ary_of_keys_2.map { | key |
      str = @hash [ key ]
      raise "Error: #{str} is not valid." unless /\A\d{2}\:\d{2}\Z/ === str
      h , m = str.split( /\:/ ).map( &:to_i )
      Time.new( time_now.year , time_now.month , time_now.day , h , m , 0 , "+09:00" )
    }
    ary += ary_of_keys_3.map { | key | @hash [ key ] }

    # puts "○ Women only car"
    # puts ary.to_s
    # puts ""

    return ary
  end

  def self.instance_class
    ::TokyoMetro::Api::RailwayLine::Info::WomenOnlyCar::Info
  end

end