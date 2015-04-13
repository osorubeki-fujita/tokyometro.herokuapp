# 駅名のリストを作成するときの各駅の情報を扱うクラス
class TokyoMetro::Factory::YamlStationList::EachStation

  # スラッシュ（前後に空白がある場合はそれも含む）にマッチする正規表現
  REGEXP_FOR_SPLIT = / *\/ */

  # Constructor
  def initialize( key_of_h1 , header , contents )
    @key = key_of_h1
    @header = header
    @contents = contents
  end

  def station_info?
    /\Aodpt\.Station\:/ === @key
  end

  def station_facility_info?
    /\Aodpt\.StationFacility\:/ === @key
  end

  def to_hash_of_hash
    h = Hash.new

    @contents.each_with_index do | content , i |
      title = @header[ i ]
      border_index = self.last_index_of_station_info
      if i <= border_index
        # inspect_of_custom_alias( title , content )
        h[ title ] = set_content( title , content )
      else
        case title
        when "administrator" , "other_operator"
          h[ title ] = set_content( title , content )
        else
          set_train_types_to_hash( h , title , content )
        end
      end
    end

    return h
  end

  def station_facility
    @contents[ @header.index( "station_facility" ) ]
  end

  def station_facility_custom
    @contents[ @header.index( "station_facility_custom" ) ]
  end

  def station_facility_custom_alias
    @contents[ @header.index( "station_facility_custom_alias" ) ]
  end

  # 駅情報の最後の index（この先は停車駅情報）
  def last_index_of_station_info
    if @header.include?( "station_code" )
      @header.index( "station_code" )
    else
      @header.index( "name_en" )
    end
  end

  private

  def inspect_of_custom_alias( title , content )
    if title == "station_facility_custom" and content == @key
      custom_alias = self.station_facility_custom_alias
      unless custom_alias.nil? or custom_alias == ""
        puts custom_alias
      end
    end
  end

  # ハッシュ (h2) の値の設定
  def set_content( title , content )
    if content.instance_of?( ::String ) and REGEXP_FOR_SPLIT === content
      return content.split( REGEXP_FOR_SPLIT )

    elsif self.station_facility_info? and title == "station_facility_custom" and content == @key
      custom_alias = self.station_facility_custom_alias
      case custom_alias
      when nil , ""
        return nil
      end
    elsif self.station_info? and title == "station_facility_custom" and content == self.station_facility
      return nil
    elsif /Kojimachi\Z/ === content and title == "name_ja"
      return "麴町"
    end

    return content
  end

  def set_train_types_to_hash( h , title , content )
    train_types = title.split( / *\/ */ )
    case content
    # 停車
    when "○"
      set_train_types_to_hash__sub( h , train_types , "stop")
    # 一部停車
    when "・" , "※" , "△"
      set_train_types_to_hash__sub( h , train_types , "some_trains_stop" )
    # 運転停車（代々木上原）
    when "―"
      set_train_types_to_hash__sub( h , train_types , "stop_for_drivers" )
    end
  end

  def set_train_types_to_hash__sub( h , ary , key )
    if h[ key ].nil?
      h[ key ] = ary
    elsif h[ key ].instance_of?( ::Array )
      h[ key ] += ary
    end
  end

end