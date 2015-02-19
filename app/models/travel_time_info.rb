class TravelTimeInfo < ActiveRecord::Base
  include AssociationFromFromStation
  include AssociationFromToStation

  def to_s
    "#{ from_station.name_ja } → #{ to_station.name_ja } (#{necessary_time})"
  end

  scope :between , ->( station_a , station_b ) {
    if [ station_a , station_b ].all?( &:integer? )
      station_a , station_b = [ station_a , station_b ].map { | station_id | ::Station.find_by_id( station_id ) }
    elsif [ station_a , station_b ].all? { | item | item.instance_of?( ::String ) }
      station_a , station_b = [ station_a , station_b ].map { | station_same_as | ::Station.find_by_same_as( station_same_as ) }
    end

    unless [ station_a , station_b ].all? { | item | item.instance_of?( ::Station ) }
      raise "Error"
    end

    ids = [ station_a , station_b ].map( &:id )
    where( from_station_id: ids , to_station_id: ids )
  }

end