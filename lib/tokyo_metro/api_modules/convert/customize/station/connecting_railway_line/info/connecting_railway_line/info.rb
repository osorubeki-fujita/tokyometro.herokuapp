# @note
#   This module is prepended
#     to {TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info}
#     by {TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine::Info::ConnectingRailwayLine::Info

  # Constructor
  def initialize( railway_line , start_on: nil , index_in_station: nil , cleared: false , another_station: nil , not_recommended: false , note: nil )
    super( railway_line )
    @start_on = set_start_on( start_on )

    @index_in_station = index_in_station
    @cleared = cleared

    @another_station = another_station
    @not_recommended = not_recommended
    @note = note
  end

  attr_reader :start_on

  attr_reader :index_in_station

  attr_reader :another_station
  attr_reader :note

  [ :index_in_station , :another_station , :note ].each do | instance_variable |
    eval <<-DEF
      def set_#{instance_variable}( variable )
        @#{instance_variable} = variable
      end
      private :set_#{instance_variable}
    DEF
  end

  [ :cleared , :not_recommended  ].each do | instance_variable |
    eval <<-DEF
      def #{instance_variable}?
        @#{instance_variable}
      end

      def set_#{instance_variable}
        @#{instance_variable} = true
      end
      private :set_#{instance_variable}
    DEF
  end

  def recommended?
    !( not_recommended? )
  end

  def not_cleared?
    !( cleared? )
  end

  private

  def set_start_on( start_on )
    if start_on.instance_of?( ::Time ) or start_on.instance_of?( ::DateTime )
      start_on
    elsif start_on.instance_of?( ::String ) and /\A(\d{4})\.(\d{2})\.(\d{2})\Z/ =~ start_on
      ::DateTime.new( $1.to_i , $2.to_i , $3.to_i )
    elsif start_on.nil?
      nil
    else
      raise "Error"
    end
  end

end