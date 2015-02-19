# 個別の駅の情報（名称、管理事業者など）を扱うクラス
class TokyoMetro::Static::StationsInTokyoMetro::Info

  include ::TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Static::GetName

# @!group Constructor

  # Constructor
  # @param same_as [String] キー
  # @param station_facility_custom [String] 自分で設定した id
  # @param station_facility_custom_alias [String, ::Array or nil] 自分で設定した id の別名
  # @param name_ja [String] 駅名（日本語・漢字表記）
  # @param name_hira [String] 駅名（日本語・ひらがな表記）
  # @param name_in_system [String] 駅名（ローマ字表記 システム用）
  # @param name_en [String] 駅名（ローマ字表記 表示用）
  # @param administrator [String, ::Array or nil] 管理事業者
  # @param other_operator [String, ::Array or nil] その他の乗り入れ事業者
  def initialize( same_as , station_facility_custom , station_facility_custom_alias ,
    name_ja , name_hira , name_in_system , name_en , administrator , other_operator )

    @same_as = same_as
    @same_as_custom = station_facility_custom
    @same_as_custom_alias = station_facility_custom_alias

    @name = name_ja
    @name_hira = name_hira
    @name_in_system = name_in_system
    @name_en = name_en

    @administrator = set_operator_name( administrator )
    @other_operator = set_operator_name( other_operator )

    @invalid_names_hira = set_invalid_names_hira
    # @invalid_names = set_invalid_names
    @regexp_of_invalid_inputs = set_regexp_of_invalid_inputs
  end

# @!group 駅施設の ID に関するメソッド

  # @return [String] 駅施設の ID キー
  attr_reader :same_as

  # @return [String] 自分で設定した駅施設の ID キー
  attr_reader :same_as_custom

  # @return [String or ::Array] 自分で設定した駅施設の ID キー（別名）
  attr_reader :same_as_custom_alias

# @!group 駅名に関するメソッド

  # @return [String] 駅名（日本語・漢字表記）
  attr_reader :name

  # @return [String] 駅名（日本語・ひらがな表記）
  attr_reader :name_hira

  # @return [String] 駅名（ローマ字表記 システム用）
  attr_reader :name_in_system

  # @return [String] 駅名（ローマ字表記 表示用）
  attr_reader :name_en

# @!group 管理する鉄道事業者に関するメソッド

  # @return [::Array <TokyoMetro::Static::Operator::Info>] 管理事業者
  attr_reader :administrator

  # @return [::Array <TokyoMetro::Static::Operator::Info>] その他の乗り入れ事業者
  attr_reader :other_operator

# @!group 検索時に想定される誤った入力に関するメソッド

  # @return [::Array <String>] 誤った文字列（ひらがな）
  attr_reader :invalid_names_hira

  # @return [::Array <Regexp>] 誤った文字列（漢字・正規表現）
  attr_reader :regexp_of_invalid_inputs

# @!group インスタンスの基本的な情報を取得するメソッド

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( others )
    @same_as <=> others.same_as
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)

      case v
      when :@administrator , :@other_operator
        val = val.map( &:same_as ).join("／")
      else
        if val.instance_of?( ::Array )
          val = val.map( &:to_s ).join("／")
        else
          val = val.to_s
        end
      end

      " " * indent + k + val
    }.join( "\n" )
  end

  private

  def set_operator_name( info )
    if info.nil?
      return ::Array.new
    elsif info.instance_of?( ::String ) or info.instance_of?( ::Array )
      ary_of_info = [ info ].flatten
    else
      raise "Error"
    end

    ary_of_info.map { | operator |
      # 事業者のインスタンスを取得
      instance_of_operator = ::TokyoMetro::Static.operators[ operator ]
      # ハッシュの返り値が nil の場合
      if instance_of_operator.nil?
        # 取得のやり直し
        # puts "● #{operator}"
        regexp = /\A(odpt\.Operator\:[\w\-]+)\.[\w]+\Z/
        if regexp === operator
          operator_name = operator.gsub( regexp ) { "#{$1}" }
          # puts "#{operator} => #{ operator_name }"
          instance_of_operator = ::TokyoMetro::Static.operators[ operator_name ]
        end
      end
      # やり直しても返り値が nil の場合
      if instance_of_operator.nil?
        raise "Error: The value for the key \"#{operator}\" does not exist."
      end
      instance_of_operator
    }
  end

  # 検索のときに誤って入力されそうな駅名
  # @return [::Array]
  def set_invalid_names_hira
    ary = ::Array.new

    set_invalid_names_hira__sub( ary , "町" , "まち" , "ちょう" )
    set_invalid_names_hira__sub( ary , "谷" , "や" , "たに" , "だに" )
    set_invalid_names_hira__sub( ary , "阪" , "さか" , "ざか" )
    set_invalid_names_hira__sub( ary , "込" , "こめ" , "ごめ" , "こみ" )

    set_invalid_names_hira__sub( ary , "原" , "はら" , "ばら" , exception_settings: [ "原宿" , "秋葉原" ] )
    set_invalid_names_hira__sub( ary , "宿" , "しゅく" , "じゅく" , exception_settings: [ "新宿" , "原宿" ] )

    set_invalid_names_hira__sub( ary , "木" , "き" , "ぎ" , first: false , exception_settings: "木場" )
    set_invalid_names_hira__sub( ary , "寺" , "じ" , "てら" , "でら" , first: false , exception_settings: "高円寺" )
    set_invalid_names_hira__sub( ary , "上" , "うえ" , "かみ" , first: false , exception_settings: "上野" )
    set_invalid_names_hira__sub( ary , "馬" , "うま" , "ま" , "ば" , exception_settings: [ "高田馬場" , "小伝馬町" ] )

    set_invalid_names_hira__sub( ary , "橋" , "はし" , "ばし" , first: false , after_nn: false ) # 新橋、日本橋
    set_invalid_names_hira__sub( ary , "田" , "た" , "だ" , first: false , after_nn: false ) # 神田

    set_invalid_names_hira__sub( ary , "袋" , "ふくろ" , "ぶくろ" , first: false )
    set_invalid_names_hira__sub( ary , "堀" , "ほり" , "ぼり" , first: false )
    set_invalid_names_hira__sub( ary , "坂" , "さか" , "ざか" , first: false )
    set_invalid_names_hira__sub( ary , "津" , "つ" , "づ" , first: false )
    set_invalid_names_hira__sub( ary , "島" , "しま" , "じま" , first: false )
    set_invalid_names_hira__sub( ary , "川" , "かわ" , "がわ" , first: false )
    set_invalid_names_hira__sub( ary , "河" , "かわ" , "がわ" , first: false )
    set_invalid_names_hira__sub( ary , "上" , "あげ" , "がみ" , "かみ" , first: false )
    set_invalid_names_hira__sub( ary , "坂上" , "さかうえ" , "さかがみ" , first: false )
    set_invalid_names_hira__sub( ary , "宮" , "ぐう" , "くう" , first: false )
    set_invalid_names_hira__sub( ary , "淵" , "ふち" , "ぶち" , first: false )
    set_invalid_names_hira__sub( ary , "渕" , "ふち" , "ぶち" , first: false )

    set_invalid_names_hira__sub( ary , "赤羽" , "あかばね" , "あかはね" )
    set_invalid_names_hira__sub( ary , "白金" , "しろかね" , "しろがね" )
    set_invalid_names_hira__sub( ary , "千住" , "せんじゅ" , "せんじゅう" )
    set_invalid_names_hira__sub( ary , "行徳" , "ぎょうとく" , "こうとく" )
    set_invalid_names_hira__sub( ary , "秋葉原" , "あきはばら" , "あきばはら" )
    set_invalid_names_hira__sub( ary , "神保町" , "じんぼうちょう" , "じんぼちょう" , "じんぼまち" )

    ary.uniq
  end

  def set_invalid_names_hira__sub( ary , kanji , *hira , first: true , after_nn: true  , exception_settings: nil)
    raise "Error" if hira.length < 2

    #-------- 判定する駅名か
    to_process = set_invalid_names_hira__sub__decision( hira , after_nn , exception_settings )

    if to_process
      #---- if 文 ここから
      regexp =
        if first
          /#{kanji}/
        else
          /\A.+#{kanji}/
        end
      if regexp === @name
        # 組み合わせを生成して処理 ここから
        hira.combination(2).each do | group |
          [ group , group.reverse ].each do |g|
            a , b = g
            if /#{a}/ === @name_hira
              set_invalid_names_hira__add_to_array( ary , @name_hira.gsub( /#{a}/ , b ) )
            end
          end
        end
        # 組み合わせを生成して処理 ここまで
      end
      #---- if 文 ここまで
    end
    #-------- unless 文 ここまで
  end

  def set_invalid_names_hira__sub__decision( hira , after_nn , exception_settings )

    #---- 「after_nn が true かつ、hira の配列の各要素の頭に "ん" を付けたもののうち @name_hira にマッチするものがある」
    # → 【判定しない】
    condition_1 = !( after_nn and [ hira ].any? { | str | /ん#{str}/ === @name_hira } )

    #---- 「exception_settings （の配列）の中に @name にマッチするものがある」
    # → 【判定しない】
    #  単純な文字列の比較ではなく、正規表現を用いて判定する。
    #  これは、例えば exception_settings に "高円寺" を指定したとき、「東高円寺」「新高円寺」両方にマッチさせるため。
    if exception_settings.nil?
      condition_2 =true
    else
      ary_of_exception_settings = [ exception_settings ].flatten
      condition_2 =!( ary_of_exception_settings.any? { | str | /#{str}/ === @name } )
    end

    condition_1 and condition_2
  end

  # 誤った文字列を配列に追加するメソッド
  # @note unless 節には、ary に追加しない文字列を指定する。
  def set_invalid_names_hira__add_to_array( ary , str )
    unless str == "こでんちょうょう"
      ary << str
    end
  end

  def set_regexp_of_invalid_inputs
    ary = ::Array.new

    case @name

    #---- 「の」

    when "虎ノ門"
      ary << /\A虎[ﾉの]?門\Z/
    when "御茶ノ水"
      ary << /\A[御お]?茶[ノﾉの]?水\Z/
    when "新御茶ノ水"
      ary << /\A新[御お]?茶[ノﾉの]?水\Z/

    #---- 「つ」

    when "四ツ谷"
      ary << /\A四[ﾂッつ]?谷\Z/
    when "四谷三丁目"
      ary << /\A四[ﾂッつツ]?谷三丁目\Z/

    #---- 「が」

    when "霞ケ関"
      ary << /\A霞[ｹヶガが]?関\Z/
    when "南阿佐ケ谷"
      ary << /\A南阿佐[ｹヶガが]?谷\Z/
    when "市ケ谷"
      ary << /\A市[ｹヶガが]?谷\Z/
    when "西ケ原"
      ary << /\A西[ｹヶガが]?原\Z/
    when "雑司が谷"
      ary << /\A雑司[ｹケヶガ]?谷\Z/

    #---- その他

    when "赤坂"
      ary << /\A赤[坂阪]\Z/
    when "赤坂見附"
      ary << /\A赤[坂阪]見[付附]\Z/
    when "麹町" , "麴町"
      ary << /\A(?:麹|糀|こうじ)町\Z/
    end

    if /\A押上/ === @name
      ary << /\A押上(?:[\<＜〈（\(]?スカイツリー前[\>＞〉）\)]?)?\Z/
    elsif /\A明治神宮前/ === @name
      ary << /\A明治神宮前(?:[\<＜〈（\(]?原宿[\>＞〉）\)]?)?\Z/
    end

    ary
  end

# @!endgroup

end