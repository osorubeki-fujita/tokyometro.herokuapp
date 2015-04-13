class TokyoMetro::Api::TrainLocation::Info::Delay

  def initialize( delay )
    @delay = delay.try( :floor )
  end

  attr_reader :delay

  def displayed_in_train_information?
    @delay.present? and @delay > 0
  end

  def sec
    @delay
  end

  def min
    ( @delay * 1.0 / 60 ).ceil
  end

  def decorate( request )
    ::TokyoMetro::Api::TrainLocation::Info::Delay::Decorator.new( request , self )
  end

  def hour_part
    @delay / 3600
  end

  def min_part( add_hour_part: false )
    _min_part = @delay / 60
    if add_hour_part
      _min_part % 60
    else
      _min_part
    end
  end

  def sec_part
    @delay % 60
  end

  def to_h( add_hour_part: false )
    if add_hour_part
      { hour: hour_part , min: min_part( add_hour_part: true ) , sec: sec_part }
    else
      { min: min_part , sec: sec_part }
    end
  end

  def to_s_separated_by_comma( add_hour_part: false )
    ary = ::Array.new
    if add_hour_part
      ary << hour_part
    end
    ary << sprintf( "%02d" , min_part( add_hour_part: add_hour_part ) )
    ary << sprintf( "%02d" , sec_part )
    ary.map( &:to_s ).join( ":" )
  end

  def to_s_ja( add_hour_part: false )
    ary = ::Array.new
    if add_hour_part
      ary << hour_part
      ary << "時間"
    end
    ary << min_part( add_hour_part: add_hour_part )
    ary << "分"
    ary << sec_part
    ary << "秒"
    ary.map( &:to_s ).join
  end

  def to_s_en( add_hour_part: false )
    ary = ::Array.new
    if add_hour_part
      ary << hour_part
      ary << "hour"
    end
    ary << min_part( add_hour_part: add_hour_part )
    ary << "min"
    ary << sec_part
    ary << "秒"
    ary.map( &:to_s ).join( " " )
  end

end