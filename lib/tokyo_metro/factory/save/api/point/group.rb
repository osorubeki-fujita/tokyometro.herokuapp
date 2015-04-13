# 地物情報 ug:Poi のデータを保存するためのクラス
class TokyoMetro::Factory::Save::Api::Point::Group < TokyoMetro::Factory::Save::Api::MetaClass::Group

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  class << self
    # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    undef :key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated
  end

  private

  def grouped_data_when_instance_is_not_generated
    @data.group_by { | element_of_list |
      get_station_facility_from_id( element_of_list[ "\@id" ] )
    }
  end

  def get_station_facility_from_id( id_str )
    station_facility_key = nil
    set_api_const_unless_exist

    _station_facility_key = station_facility_key_of( id_str )

    if _station_facility_key.present?
      return _station_facility_key
    else

    end
  end

  def set_api_const_unless_exist
    unless ::TokyoMetro::Api.constants.include?( :STATION )
      ::TokyoMetro::Api.const_set( :STATION , ::TokyoMetro::Api::Station.generate_from_saved_json )
    end
  end

  def station_facility_key( id_str )
    ::TokyoMetro::Api.stations.each do | station |
      if station.exit_list.include_info_of?( id_str )
        station_facility = station.facility
        if station_facility.string?
          return station_facility
        else
          return station_facility.same_as
        end

      end
    end
    raise "Error: station exit list that contains \'#{ id_str }\' was not found."
  end

  alias :station_facility_key_of :station_facility_key

end