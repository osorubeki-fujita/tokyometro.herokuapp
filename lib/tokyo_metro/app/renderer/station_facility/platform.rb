class TokyoMetro::App::Renderer::StationFacility::Platform < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , station_facility )
    super( request )
    @station_facility = station_facility
    @platform_infos_grouped_by_railway_line = platform_infos_grouped_by_railway_line
    @type_of_platform_infos = type_of_platform_infos
  end

  def to_a
    ary = ::Array.new
    case @type_of_platform_infos
    when :between_wakoshi_and_kotake_mukaihara
      ary << ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::BetweenWakoshiAndKotakeMukaihara::Whole.new(
        request ,
        @platform_infos_grouped_by_railway_line.values.first ,
        ::RailwayLine.where( id: railway_line_ids_of_platform_infos )
      )

    when :between_meguro_and_shirokane_takanawa
      ary << ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::BetweenMeguroAndShirokaneTakanawa::Whole.new(
        request ,
        @platform_infos_grouped_by_railway_line.values.first ,
        ::RailwayLine.where( same_as: [ "odpt.Railway:TokyoMetro.Namboku" , "odpt.Railway:Toei.Mita" ] ).order( :id )
      )

    when :normal
      @platform_infos_grouped_by_railway_line.each do | railway_line_id , platform_infos |
        ary << ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::Normal::Whole.new(
          request ,
          platform_infos ,
          ::RailwayLine.find( railway_line_id )
        )
      end

    end

    ::TokyoMetro::App::Renderer::StationFacility::Platform::List.new( @resuest , ary )
  end

  def self.make_list( request , station_facility )
    self.new( request , station_facility ).to_a
  end

  private

  def platform_infos_grouped_by_railway_line
    @station_facility.platform_infos.includes(
      :railway_direction ,
      :station_facility_platform_info_barrier_free_facility_infos ,
      :station_facility_platform_info_transfer_infos ,
      :station_facility_platform_info_surrounding_areas ,
      :barrier_free_facility_infos ,
      :surrounding_areas
    ).group_by( &:railway_line_id )
  end

  def type_of_platform_infos
    if platform_infos_of_yurakucho_and_fukutoshin_line_between_wakoshi_and_kotake_mukaihara?
      :between_wakoshi_and_kotake_mukaihara
    elsif platform_infos_of_namboku_and_toei_mita_line_between_meguro_and_shirokane_takanawa?
      :between_meguro_and_shirokane_takanawa
    else
      :normal
    end
  end

  def railway_line_ids_of_platform_infos
    @platform_infos_grouped_by_railway_line.keys.sort
  end

  # @!group 路線と駅の判定

  def platform_infos_of_yurakucho_and_fukutoshin_line_between_wakoshi_and_kotake_mukaihara?
    platform_infos_of_yurakucho_and_fukutoshin_line? and between_wakoshi_and_kotake_mukaihara?
  end

  def platform_infos_of_namboku_and_toei_mita_line_between_meguro_and_shirokane_takanawa?
    platform_infos_of_namboku_line? and between_meguro_and_shirokane_takanawa?
  end

  # @!group 路線の判定

  def platform_infos_of_yurakucho_and_fukutoshin_line?
    platform_infos_of?( *( ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_same_as ) )
  end

  def platform_infos_of_namboku_line?
    platform_infos_of?( "odpt.Railway:TokyoMetro.Namboku" )
  end

  def platform_infos_of?( *ary )
    railway_line_ids_of_platform_infos.map { | railway_line_id | ::RailwayLine.find( railway_line_id ).same_as } == ary
  end

  # @!group 駅の判定

  def between_wakoshi_and_kotake_mukaihara?
    ary = ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_kotake_mukaihara_in_system
    at_these_stations?( ary )
  end

  def between_meguro_and_shirokane_takanawa?
    ary = ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.namboku_and_toei_mita_line_common_stations_in_system
    at_these_stations?( ary )
  end

  def at_these_stations?( stations_in_system )
    stations_in_system.map { | station | "odpt.StationFacility:TokyoMetro.#{station}" }.include?( @station_facility.same_as )
  end

  # @!endgroup

end