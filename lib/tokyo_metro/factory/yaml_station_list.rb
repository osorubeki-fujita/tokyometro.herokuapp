# 駅名のリストを作成するためのクラス（メタクラス）
class TokyoMetro::Factory::YamlStationList

  # 駅名の CSV ファイルを処理し、YAML ファイルに変換するメソッド
  # @return [nil]
  def self.process
    puts "● #{self.name} - Make list of stations"
    puts ""

    files = Dir.glob( "#{ ::TokyoMetro::DB_DIR }/dictionary/station/**/**.csv" )

    files.each do | file |
      header , *rows = open( file , "r:Windows-31j" ).read.encode( "UTF-8" ).split( "\n" ).map { | row | row.split( "\," ) }
      title_of_table , *header = header

      hash_of_hash = make_hash_of_hash( header , rows )
      str = make_yaml_str( hash_of_hash )

      file_generated = file.gsub( "#{ ::TokyoMetro::DB_DIR }/dictionary" , ::TokyoMetro.dictionary_dir ).gsub( /\.csv\Z/ , ".yaml" )
      File.open( file_generated , "w:utf-8" ) do | file |
        file.print( str )
      end
    end
    return nil
  end

  class << self

    private

    def make_hash_of_hash( header , rows )
      h1 = Hash.new

      #---- ハッシュ (h1) の値となるハッシュ (h2) の作成 ここから
      rows.each do | row |
        key_of_h1 , *contents = row
        info = EachStation.new( key_of_h1 , header , contents )
        h1[ key_of_h1 ] = info.to_hash_of_hash
      end
      #---- ハッシュ (h1) の値となるハッシュ (h2) の作成 ここまで
      # puts h1.to_s
      h1
    end

    def make_yaml_str( h1 )
      str_ary = ::Array.new
      h1.each do | key , h2 |
        str_ary_for_each_element = ::Array.new
        str_ary_for_each_element << "#{key}\:"
        h2.each do | title , value_of_h2 |
          set_yaml_str_for_each_value( title , value_of_h2 , str_ary_for_each_element )
        end
        str_ary << str_ary_for_each_element.join( "\n" )
      end
      str_ary.join( "\n" * 2 )
    end

    def set_yaml_str_for_each_value( title , value_of_h2 , str_ary_for_each_element )
      unless value_of_h2.nil? or ( value_of_h2.instance_of?( ::String ) and /\A *\Z/ === value_of_h2 )
        if value_of_h2.instance_of?( ::String )
          str_ary_for_each_element << " " * 2 + "#{title}\: #{ value_of_h2 }"

        elsif value_of_h2.instance_of?( ::Array )
          str_ary_for_each_element << " " * 2 + "#{title}\:"
          value_of_h2.each do | element_of_list |
            str_ary_for_each_element << " " * 4 + "- #{element_of_list}"
          end

        elsif value_of_h2.instance_of?( Hash ) and value_of_h2.values.all? { |i| i.instance_of?( ::String ) }
          str_ary_for_each_element << " " * 2 + "#{title}\:"
          value_of_h2.each do | key , value |
            str_ary_for_each_element << " " * 4 + "#{title}\: #{value}"
          end

        else
          raise "Error\: #{value.class.name} is not valid."
        end
      end
    end

  end

end