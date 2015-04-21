# API からデータを取得するための Factory Pattern のクラス（最上位クラス）
class TokyoMetro::Factory::Get::Api::MetaClass::Fundamental

  include ::OdptCommon::CalcTime

  # Constructor
  # @param perse_json [Boolean] JSON をパースするか否かの設定
  # @param generate_instance [Boolean] JSON を変換し Ruby のインスタンスを作成するか否かの設定
  # @note generate_instance を true にする場合は、perse_json も true にしなければならない。
  def initialize( perse_json , generate_instance , to_inspect )
    if generate_instance and !( perse_json )
      raise "Error: If you want to generate instance, you must set \"generate_instance\" to true and \"perse_json\" to true."
    end
    @perse_json = perse_json
    @generate_instance = generate_instance
    @to_inspect = to_inspect
  end

  def self.rdf_type
    self.info_class.rdf_type
  end

  # パラメータを格納したハッシュを取得するメソッド
  # @return [Hash]
  def parameters
    { "rdf:type" => self.class.rdf_type , "acl:consumerKey" => ::TokyoMetro::ACCESS_TOKEN }
  end

  # API からデータを取得するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】
  # @return [::Array <Hash>] インスタンス変数 perse_json が true の場合は、JSON を配列に変換して返す。
  # @return [String] インスタンス変数 perse_json が false の場合は、JSON を文字列として返す。
  def get_data( http_client )
    check_validity_of_settings( http_client )
    if @to_inspect
      time_begin = Time.now
      # progress_bar = ::ForRails::Progress.new
      # progress_bar.display( parameters_to_strf )
      puts "-" * 128
      puts ""
      puts parameters_to_strf
      puts ""
    end
    response = response_from_api( http_client )
    if @to_inspect
      t = calc_time( time_begin )
      puts "Download: #{t} sec"
      puts ""
    end

    process_response( response )
  end

  private

  def check_validity_of_settings( http_client )
    raise "Error" unless ::TokyoMetro::ACCESS_TOKEN.string?
    raise "Error" unless http_client.instance_of?( ::HTTPClient )
    unless self.class.rdf_type.string?
      raise "Error"
    end
  end

  def parameters_to_strf
    parameters.map { | k , v | k.ljust(24) + " ... " + v }.join( "\n" )
  end

  # API からのレスポンスを受け取るメソッド
  # @param http_client [::HTTPClient] HTTPクライアント
  def response_from_api( http_client )
    http_client.get( access_point_url , self.parameters )
  end

  # API のレスポンスを設定に応じて処理するメソッド
  # @param response [HTTPClient] API のレスポンス
  # @return [subclass of ::TokyoMetro::Api::MetaClass::Fundamental::List] JSON を変換し Ruby のインスタンスが作成される場合
  # @return [::Array] JSON をパースするだけで、Ruby のインスタンスを作成しない場合
  # @return [String] JSON をパースしない場合
  def process_response( response )
    if @perse_json
      ary = persed_json( response )
      if @generate_instance
        generate_new_array_instance( ary )
      else
        ary
      end
    else
      body_of_response( response )
    end
  end

  # レスポンスの body 部分を取得するメソッド
  # @param response [HTTPClient] API のレスポンス
  # @return [Stirng]
  def body_of_response( response )
    response.body
  end

  # レスポンスの body 部分の JSON をパースし、配列やハッシュに変換するメソッド
  # @param response [HTTPClient] API のレスポンス
  # @return [::Array or Hash]
  def persed_json( response )
    ::JSON.parse( body_of_response( response ) )
  end

  # JSON や YAML をパースして得られた配列を処理し、配列のクラスの変更と中身のハッシュのインスタンスへの置き換えを行うメソッド
  # @param ary [::Array] JSON や YAML をパースして得られた配列
  # @return [TokyoMetro::Api::Fundamental::List (or its sub-class)]
  def generate_new_array_instance( ary )
    unless ary.all?{ |i| i.instance_of?( Hash ) }
      raise "Error"
    end
    list_class = self.class.list_class
    info_class = self.class.info_class
    list_class.new( ary.map { | element |
      info_class.generate_from_hash( element )
    } )
  end

end