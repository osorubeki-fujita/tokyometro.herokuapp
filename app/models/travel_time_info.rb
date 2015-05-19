class TravelTimeInfo < ActiveRecord::Base
  include ::Association::To::FromStation::Info
  include ::Association::To::ToStation::Info

  def to_s
    "#{ from_station_info.decorate.name_ja_actual } → #{ to_station_info.decorate.name_ja_actual } (#{necessary_time})"
  end

  scope :between , ->( station_a , station_b ) {
    if [ station_a , station_b ].all?( &:integer? )
      station_a , station_b = [ station_a , station_b ].map { | station_info_id | ::Station::Info.find_by_id( station_info_id ) }
    elsif [ station_a , station_b ].all? { | item | item.instance_of?( ::String ) }
      station_a , station_b = [ station_a , station_b ].map { | station_same_as | ::Station::Info.find_by_same_as( station_same_as ) }
    end

    unless [ station_a , station_b ].all? { | item | item.instance_of?( ::Station::Info ) }
      raise "Error"
    end

    ids = [ station_a , station_b ].map( &:id )
    where( from_station_info_id: ids , to_station_info_id: ids )
  }

end
