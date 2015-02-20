# @note
#   This module is prepended
#     to {TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info}
#     by {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Info::ConnectingRailwayLine::Info

  include ::TokyoMetro::Modules::Common::Info::Station::ConnectingRailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewRailwayLine
  include ::TokyoMetro::Modules::Common::Info::NewRailwayLine::SetStartOn

  # Constructor
  def initialize( railway_line , start_on: nil , index_in_station: nil , cleared: false , connecting_another_station: nil , not_recommended: false , note: nil )
    super( railway_line )
    @start_on = set_start_on( start_on )

    @index_in_station = index_in_station
    @cleared = cleared

    @connecting_another_station = connecting_another_station
    @not_recommended = not_recommended
    @note = note
  end

  attr_reader :start_on

  attr_reader :index_in_station

  attr_reader :connecting_another_station
  attr_reader :note

  [ :index_in_station , :connecting_another_station , :note ].each do | instance_variable |
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

  def connecting_to_another_station?
    connecting_another_station.present?
  end

end