# @note
#   This module is prepended
#     to {TokyoMetro::Factories::Seed::Api::Station::Info::ConnectingRailwayLine::Info}
#     by {TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine.set_modules} .
module TokyoMetro::ApiModules::Convert::Customize::Station::ConnectingRailwayLine::Factories::Seed::Info::ConnectingRailwayLine::Info

  private

  # @todo railway_line_id の列を廃止する（他社線の駅名情報も DB に登録し、すべての railway_line_id へ station_id からアクセスできるようにする）
  def hash_to_db
    super.merge({
      # station_id: @station_id ,
      # railway_line_id: railway_line_id ,
      index_in_station: @info.index_in_station ,
      connecting_station_id: connecting_station_id ,
      connecting_to_another_station: connecting_to_another_station? ,
      cleared: @info.cleared? ,
      not_recommended: @info.not_recommended? ,
      connecting_railway_line_note_id: connecting_railway_line_note_id
    })
  end

  def connecting_to_another_station?
    @info.another_station.present?
  end

  def connecting_station_id
    if connecting_to_another_station?
      station = ::Station.find_by( railway_line_id: railway_line_id , same_as: @info.another_station )
      unless station.present?
        raise "Error: railway_line_id: #{railway_line_id} / same_as: #{ @info.another_station }"
      end
      station.id

    else
      station_name_in_system = ::Station.find( @station_id ).name_in_system
      connecting_station = ::Station.find_by( railway_line_id: railway_line_id , name_in_system: station_name_in_system )
      if connecting_station.present?
        connecting_station.id
      else
        nil
      end

    end
  end

  def connecting_railway_line_note_id
    if @info.note.present?
      ::ConnectingRailwayLineNote.find_or_create_by( note: @info.note ).id
     else
      nil
    end
  end

end