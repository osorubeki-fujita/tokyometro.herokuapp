# 地物情報 ug:Poi のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::Point < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  # ディレクトリ、ファイル名の設定
  # @return [::Symbol or nil]
  def self.settings_for_dirname_and_filename
    :alphabet
  end

  # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  # @return [String or Symbol]
  def self.method_name_when_instance_is_generated
    :station
  end

  def self.regexp_for_filename
    /\odpt\.StationFacility\:/
  end

  class << self
    # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    undef :key_name_when_determine_dir
  end

  private

  def grouped_data_when_instance_is_not_generated
    @data.group_by { | element_of_list | get_station_facility_from_id( element_of_list[ "\@id" ] ) }
  end

  def get_station_facility_from_id( id_str )
    station_facility_key = nil

    unless ::TokyoMetro::Api.constants.include?( :STATION )
      ::TokyoMetro::Api.const_set( :STATION , ::TokyoMetro::Api::Station.generate_from_saved_json )
    end

    ::TokyoMetro::Api.stations.each do | station |
      if station.exit_list.include?( id_str )
        station_facility = station.facility
        if station_facility.string?
          station_facility_key = station_facility
        else
          station_facility_key = station_facility.same_as
        end
        break
      end
    end

    if station_facility_key.present?
      return station_facility_key
    else
      raise "Error"
    end

  end

end