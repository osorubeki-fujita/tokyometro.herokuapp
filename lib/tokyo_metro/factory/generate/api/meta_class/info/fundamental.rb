# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  # Constructor
  # @param var [Hash or String] インスタンスの元となるハッシュ
  # @note ハッシュは第1階層の情報であるとは限らない。
  def initialize( var , on_the_top_layer: true )
    @on_the_top_layer = on_the_top_layer
    if to_check_validity?
      check_validity( var )
    end
    if var.instance_of?( ::Hash )
      @hash = var
    elsif var.instance_of?( ::String )
      @string = var
    elsif var.instance_of?( ::Array )
      @array = var
    end
  end

  # API から取得したハッシュからインスタンスを生成するためのインスタンスメソッド
  # @note ハッシュは第1階層の情報であるとは限らない。
  # @return [Object] self.class.info_class のインスタンス
  def generate
    self.class.instance_class.new( *variables )
  end

  def to_check_validity?
    @on_the_top_layer
  end

  # API から取得したハッシュからインスタンスを生成するためのクラスメソッド
  # @param h [Hash] インスタンスの元となるハッシュ
  # @note ハッシュは第1階層の情報であるとは限らない。
  def self.process(h)
    self.new(h).generate
  end

  def self.instance_class
    info_class
  end

  private

  # Info クラスに送る変数のリスト
  # @return [::Array]
  # @raise [RuntimeError] サブクラスで定義するため、このクラスでは例外が発生するようにしている。
  def variables
    raise "The class method \"#{__method__}\" is not defined yet in this class."
  end

  # API から取得したデータをもとにインスタンスを作成する際に、RDF タイプ、 Context などが正しいか否かをチェックするメソッド (1)
  # @param h [Hash] API から取得したデータのハッシュ
  # @return [nil]
  def check_validity( h , barrier_free: false )
    class_methods_in_toplevel_namespace = self.class.instance_class.methods.sort

    ary = ::Array.new
    unless barrier_free
      ary << [ :rdf_type , "\@type" ] # (e.g.) ::TokyoMetro::Api::StationTimetable.rdf_type (Class Method)
      ary << [ :context , "\@context" ] # (e.g.) ::TokyoMetro::Api::StationTimetable.context (Class Method)
    else
      ary << [ :rdf_type_of_facility , "\@type" ]
      ary << [ :category_name , "ugsrv:categoryName" ] # (e.g.) ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Toilet.category_name (Class Method)
      ary << [ :spac__is_available_to , "spac:isAvailableTo" ] # (e.g.) ::TokyoMetro::Api::StationFacility::Info::BarrierFree::LinkForMobilityScooter.spac__is_available_to (Class Method)
    end

    ary.each do | class_method_name , hash_key |

      if class_methods_in_toplevel_namespace.include?( class_method_name )
        valid_value_of_hash = self.class.instance_class.send( class_method_name )

        check_validity__sub_convert_elevator_and_escalator( h , hash_key , valid_value_of_hash )
        check_validity__sub_raise_error( h , hash_key , valid_value_of_hash )
      end

    end
  end

  def check_validity__sub_convert_elevator_and_escalator( h , hash_key , valid_value_of_hash )
    unless h[ hash_key ] == valid_value_of_hash
      case valid_value_of_hash
      when "エレベータ" , "エスカレータ"
        invalid_str = "#{valid_value_of_hash}ー"
        if h[ hash_key ] == invalid_str
          h[ hash_key ] = valid_value_of_hash
          # puts "=" * 8 + " ☆ Convert"
          # puts h[ "owl:sameAs" ]
          # puts "#{invalid_str} => #{valid_value_of_hash}"
          # puts ""
        # elsif h[ hash_key ] == valid_value_of_hash
          # puts "-" * 8 + " ○ No convert"
          # puts h[ "owl:sameAs" ]
          # puts ""
        end
      end
    end
  end

  def check_validity__sub_raise_error( h , hash_key , valid_value_of_hash )
    if h[ hash_key ].present? and h[ hash_key ] != valid_value_of_hash
      puts "● Error"
      puts h.to_s
      puts ""
      puts "Error: The value of #{hash_key} (#{ h[ hash_key ].to_s }\[#{ h[ hash_key ].class.name }\], from API) is not valid."
      puts "  It should be \"#{ valid_value_of_hash }\" \[#{ valid_value_of_hash.class.name }\]."
      puts "Instance Class: #{ self.class.instance_class }"
      raise "Error"
    end
  end

end