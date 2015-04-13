# @note
#   This module is prepended
#     to {TokyoMetro::Factory::Seed::Api::Station::Info::ConnectingRailwayLine::Info}
#     by {TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::Modules::Api::Convert::Customize::Station::ConnectingRailwayLine::Factory::Seed::Info::ConnectingRailwayLine::Info

  private

  # @todo railway_line_id の列を廃止する（他社線の駅名情報も DB に登録し、すべての railway_line_id へ station_id からアクセスできるようにする）
  def hash_to_db
    super.merge({
      # station_id: @station_id ,
      # railway_line_id: railway_line_id ,
      index_in_station: @info.index_in_station ,
      connecting_station_id: connecting_station_id ,
      connecting_to_another_station: connecting_to_another_station? ,
      cleared: cleared? ,
      not_recommended: not_recommended? ,
      connecting_railway_line_note_id: connecting_railway_line_note_id ,
      start_on: @info.start_on
    })
  end

  [ :connecting_to_another_station? , :cleared? , :recommended? , :not_recommended? ].each do | method_name |
    eval <<-DEF
      def #{method_name}
        @info.#{method_name}
      end
    DEF
  end

  def connecting_station
    if connecting_to_another_station?
      station = ::Station.find_by( railway_line_id: railway_line_id , same_as: @info.connecting_station )
      unless station.present?
        raise "Error: railway_line_id: #{railway_line_id} / same_as: #{ @info.connecting_another_station }"
      end
      return station
    else
      station_name_in_system = ::Station.find( @station_id ).name_in_system
      connecting_station = ::Station.find_by( railway_line_id: railway_line_id , name_in_system: station_name_in_system )
      if connecting_station.present?
        connecting_station
      else
        nil
      end
    end
  end

  def connecting_station_id
    connecting_station.try( :id )
  end

  def connecting_railway_line_note_id
    if @info.note.present?
      ::ConnectingRailwayLineNote.find_or_create_by( note: @info.note ).id
     else
      nil
    end
  end

end