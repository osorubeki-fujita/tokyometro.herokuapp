class TokyoMetro::Factory::Seed::Static::Station::Info < TokyoMetro::Factory::Seed::Static::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::Station

  include ::TokyoMetro::Factory::Seed::Reference::Operator
  include ::TokyoMetro::Factory::Seed::Reference::Station
  include ::TokyoMetro::Factory::Seed::Reference::StationFacility

  include ::TokyoMetro::Factory::Seed::Static::Station::OptionalVariables

  private

  alias :create_station :seed_main

  def seed_main
    if station_already_exists_in_db?
      update_station
    else
      unless station_facility_already_exists_in_db?
        create_station_facility
      end
      create_station
    end
  end

  def seed_optional_infos
    # StationNameAlias , 停車駅の処理
    seed_station_name_alias
    seed_station_facility_custom

    seed_stopping_patterns
  end

  def station_already_exists_in_db?
    ::Station.exists?( same_as: @info.same_as )
  end

  def station_facility_already_exists_in_db?
    ::StationFacility.exists?( same_as: @info.station_facility )
  end

  def update_station
    ::Station.find_by_same_as( @info.same_as ).update( hash_for_updating_db )
  end

  def create_station_facility
    ::StationFacility.find_or_create_by( same_as: @info.station_facility )
  end

  def hash_for_updating_db
    h = ::Hash.new
    [ :name_hira , :name_in_system , :name_en , :index_in_railway_line ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end
    h
  end

  def hash_to_db
    h = ::Hash.new

    h[ :station_facility_id ] = station_facility_id
    h[ :railway_line_id ] = @railway_line_id
    h[ :operator_id ] = ::RailwayLine.find( @railway_line_id ).operator_id

    [
      :name_ja , :name_hira , :name_in_system , :name_en , :index_in_railway_line ,
      :station_code , :same_as
    ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    h
  end

  [ :operator_in_db , :operator_id ].each do | method_name |
    eval <<-DEF
      def #{method_name}( whole = nil , search_by: @info.operator.same_as )
        super( whole = nil , search_by: search_by )
      end
    DEF
  end

  [ :station_info_in_db , :station_info_id ].each do | method_name |
    eval <<-DEF
      def #{method_name}( whole = nil , search_by: @info.same_as )
        super( whole = nil , search_by: search_by )
      end
    DEF
  end

  [ :station_facility_in_db , :station_facility_id ].each do | method_name |
    eval <<-DEF
      def #{method_name}( whole = nil , search_by: @info.station_facility )
        super( whole = nil , search_by: search_by )
      end
    DEF
  end

  def station_name_alias
    s_id = station_info_id
    if @info.station_name_alias.present?
      [ @info.station_name_alias ].flatten.each do | station_name_alias |
        ::Station::NameAlias.find_or_create_by( station_info_id: s_id , same_as: station_name_alias )
      end
    end
  end

  def seed_station_facility_custom
    if @info.station_facility_custom.present?
      ary_of_station_facility_alias = [ @info.station_facility_custom ].flatten
      if @info.station_facility_custom_alias.present?
        ary_of_station_facility_alias += [ @info.station_facility_custom_alias ].flatten
      end
      sf_id = station_facility_id
      ary_of_station_facility_alias.each.with_index(1) do | station_facility_alias , i |
        h = {
          station_facility_id: sf_id ,
          index_of_alias: i ,
          same_as: station_facility_alias
        }
        ::StationFacilityAlias.find_or_create_by(h)
      end
    end
  end

  def seed_stopping_patterns
    s_id = station_id

    seed_normal_stopping_patterns( s_id )
    seed_normal_stopping_patterns_of_some_trains( s_id )
    seed_normal_stopping_patterns_for_drivers( s_id )
  end

  def create_and_get_pattern_id( pattern )
    ::StoppingPattern.find_or_create_by( same_as: pattern ).id
  end

  def seed_normal_stopping_patterns( s_id )
    @info.stop.each do | pattern |
      p_id = create_and_get_pattern_id( pattern )
      ::StationStoppingPattern.find_or_create_by(
        station_id: s_id ,
        stopping_pattern_id: p_id ,
        partial: false ,
        for_driver: false
      )
    end
  end

  def seed_normal_stopping_patterns_of_some_trains( s_id )
    if @info.some_trains_stop.present?
      @info.some_trains_stop.each do | pattern , note |
        p_id = create_and_get_pattern_id( pattern )
        note_id = ::StationStoppingPatternNote.find_or_create_by( text: note ).id
        ::StationStoppingPattern.find_or_create_by(
          station_id: s_id ,
          stopping_pattern_id: p_id ,
          partial: true ,
          for_driver: false ,
          station_stopping_pattern_note_id: note_id
        )
      end
    end
  end

  def seed_normal_stopping_patterns_for_drivers( s_id )
    if @info.stop_for_drivers.present?
      @info.stop_for_drivers.each do | pattern |
        p_id = create_and_get_pattern_id( pattern )
        ::StationStoppingPattern.find_or_create_by(
          station_id: s_id ,
          stopping_pattern_id: p_id ,
          partial: false ,
          for_driver: true
        )
      end
    end
  end

end