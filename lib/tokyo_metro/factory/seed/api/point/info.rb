class TokyoMetro::Factory::Seed::Api::Point::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::Point
  include ::TokyoMetro::Factory::Seed::Api::Point::Common

  include ::TokyoMetro::Factory::Seed::Reference::Station

  private

  def hash_to_db
    h = ::Hash.new

    [ :id_urn , :code , :additional_info , :latitude , :longitude , :geo_json , :floor ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    [ :station_facility_id , :point_category_id ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end

    h[ :elevator ] = @info.has_elevator?
    h[ :closed ] = @info.closed?

    h
  end

  def station_in_db
    _station_in_db = @stations.find_by_name_ja( @info.station_name_for_shift_jis )
    if _station_in_db.nil?
      raise "Error: The station information of \"#{ @info.station_name_for_shift_jis }\" does not exist in the db."
    end
    _station_in_db
  end

  def station_facility_id
    station_in_db.station_facility_id
  end

  def point_category_in_db
    if @info.category_name.nil?
      raise "Error: The category name of \"#{ @info.title.to_s }\" is not valid. The category info is not defied."
    end
    ::PointCategory.find_or_create_by( name_ja: @info.category_name )
  end

  def point_category_id
    point_category_in_db.id
  end

end