# 個別の地物情報 ug:Poi のクラス
class TokyoMetro::Api::Point::Info < TokyoMetro::Api::MetaClass::Hybrid::Info

  # インスタンスメソッドの追加
  include ::TokyoMetro::ApiModules::InstanceMethods::ToJson
  include ::TokyoMetro::ApiModules::InstanceMethods::ToStringGeneral
  include ::TokyoMetro::ApiModules::InstanceMethods::ToStringWithArray

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  # Constructor
  def initialize( id_urn , title , geo_long , geo_lat , region , ug_floor , category_name )
    @id_urn = id_urn

    @title = title
    @geo_long = geo_long
    @geo_lat = geo_lat
    @region = region

    @floor = ug_floor
    @category_name = category_name
  end

  # @!group 地理情報 (For developers)

  # 代表点の経度（10進表記）
  # @return [Float]
  attr_reader :geo_long

  # 代表点の緯度（10進表記）
  # @return [Float]
  attr_reader :geo_lat

  # 地物の形状データを GeoJSON で取得するためのURL <ug:region - odpt:GeoDocument>
  # @return [Integer]
  # @note 取得にはアクセストークンの付与が必要
  attr_reader :region

  # @!group 一般の情報

  # 地物のカテゴリ（必ず「出入口」となる） <ugsrv:categoryName - xsd:string>
  # @return [String]
  attr_reader :category_name

  # 地物の階数（高さ情報） <ug:floor - xsd:double>
  # @return [Integer]
  attr_reader :floor

  # 地物名 <dc:title - xsd:string>
  # @return [String]
  # @note エレベータには「エレベータ」という文字列を含む。「出入口」の文字列の後に出口番号が続く。
  attr_reader :title

  # @!group 駅情報の取得

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    to_s_with_array( [] , indent )
  end

  alias :to_strf :to_s

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "dc:title" , @title.to_s )
    set_data_to_hash( h , "ug:region" , @region )

    set_data_to_hash( h , "ug:floor" , @floor )
    set_data_to_hash( h , "ugsrv:categoryName" , @category_name )

    set_data_to_hash( h , "geo:long" , @geo_long )
    set_data_to_hash( h , "geo:lat" , @geo_lat )

    h
  end

  # @!endgroup

  def has_elevator?
    @title.has_elevator?
  end

  def closed?
    @title.closed?
  end

  def station
    station_facility_key = nil
    ::TokyoMetro::Api::stations.each do | sta |

      if sta.exit_lidt.include?( @id_urn )
        station_facility = sta.facility
        if station_facility.string?
          station_facility_key = station_facility
        else
          station_facility_key = station_facility.same_as
        end
        break
      end
    end

    if station_facility_key.present?
      station_facility_key
    else
      raise "Error"
    end
  end

  def seed( stations )
    h = { name_ja: @category_name }
    point_category = ::PointCategory.find_or_create_by(h)

    additional_info = @title.additional_info
    if additional_info.blank?
      additional_info = nil
    end

    station_name = @title.station_name
    if station_name == "麴町"
      station_name = "麹町"
    end

    station = stations.find_by( name_ja: station_name )

    raise "Error: \"#{@category_name}\" , \"#{@title.station_name}\"" if [ point_category , station ].any?{ |i| i.nil? }
    station_facility_id = station.station_facility_id

    ::Point.create(
      id_urn: @id_urn ,
      station_facility_id: station_facility_id ,
      code: @title.code ,
      additional_info: additional_info ,
      elevator: @title.has_elevator? ,
      closed: @title.closed? ,
      latitude: @geo_lat ,
      longitude: @geo_lat ,
      geo_json: @region ,
      floor: @floor ,
      point_category_id: point_category.id
    )
  end

end