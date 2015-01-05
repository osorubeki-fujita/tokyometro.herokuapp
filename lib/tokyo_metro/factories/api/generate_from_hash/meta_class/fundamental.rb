# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  # Constructor
  # @param h [Hash] インスタンスの元となるハッシュ
  # @note ハッシュは第1階層の情報であるとは限らない。
  def initialize( h , on_the_top_layer: true )
    if on_the_top_layer
      check_validity(h)
    end
    @hash = h
  end

  # Info クラスに送る変数のリスト
  # @return [::Array]
  # @raise [RuntimeError] サブクラスで定義するため、このクラスでは例外が発生するようにしている。
  def variables
    raise "The class method \"#{__method__}\" is not defined yet in this class."
  end

  # API から取得したハッシュからインスタンスを生成するためのインスタンスメソッド
  # @note ハッシュは第1階層の情報であるとは限らない。
  # @return [Object] self.class.info_class のインスタンス
  def generate
    self.class.instance_class.new( *variables )
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

  # API から取得したデータをもとにインスタンスを作成する際に、RDF タイプ、 Context などが正しいか否かをチェックするメソッド (1)
  # @param h [Hash] API から取得したデータのハッシュ
  # @return [nil]
  def check_validity(h)
    class_methods_in_toplevel_namespace = self.class.instance_class.methods.sort

    if class_methods_in_toplevel_namespace.include?( :rdf_type )
      # (e.g.) rdf_type = ::TokyoMetro::Api::StationTimetable.rdf_type (Class Method)
      check_validity__sub( h , "\@type" , self.class.instance_class.rdf_type )
    end

    if class_methods_in_toplevel_namespace.include?( :context )
      # (e.g.) context = ::TokyoMetro::Api::StationTimetable.context (Class Method)
      check_validity__sub( h , "\@context" , self.class.instance_class.context )
    end

    if class_methods_in_toplevel_namespace.include?( :category_name )
      # (e.g.) category_name = ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Toilet.category_name (Class Method)
      check_validity__sub( h , "ugsrv:categoryName" , self.class.instance_class.category_name )
    end

    if class_methods_in_toplevel_namespace.include?( :is_available_to )
      # (e.g.) category_name = ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Link.is_available_to (Class Method)
      check_validity__sub( h , "spac:isAvailableTo" , self.class.instance_class.is_available_to )
    end
  end

  # RDF タイプと Context が正しいか否かをチェックするメソッド (2) -（具体的な判定とエラーの立ち上げ）
  # @return [nil]
  def check_validity__sub( h , k , v )
    check_validity__sub_convert_elevator_and_escalator( h , k , v )
    check_validity__sub_raise_error( h , k , v )
  end

  def check_validity__sub_convert_elevator_and_escalator( h , k , v )
    unless h[ k ] == v
      case v
      when "エレベータ" , "エスカレータ"
        invalid_str = "#{v}ー"
        if h[ k ] == invalid_str
          h[ k ] = v
          # puts "=" * 8 + " ☆ Convert"
          # puts h[ "owl:sameAs" ]
          # puts "#{invalid_str} => #{v}"
          # puts ""
        # elsif h[ k ] == v
          # puts "-" * 8 + " ○ No convert"
          # puts h[ "owl:sameAs" ]
          # puts ""
        end
      end
    end
  end

  def check_validity__sub_raise_error( h , k , v )
    unless h[ k ] == v
      puts "● Error"
      puts h.to_s
      puts ""
      puts "Error: The value of #{k} (#{ h[k].to_s }\[#{ h[k].class.name}\], from API) is not valid."
      puts "  It should be \"#{ v }\"\[#{ v.class.name}\]."
      puts "Instance Class: #{ self.class.instance_class }"
      raise "Error"
    end
  end

end