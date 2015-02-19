# ハッシュに変換するとハッシュの値に配列が含まれるようなインスタンスを文字列に変換する際に使用するモジュール
# @note インスタンスメソッドとして include する。
module TokyoMetro::Modules::Api::Info::ToStringWithArray

  private

  def to_s_with_array( ary_keys_in_hash , indent )
    str_ary_1 = ::Array.new

    if ary_keys_in_hash.empty?
      self.to_h.each do | key , value |
        str_ary_1 << " " * indent + key.ljust(32) + value.to_s
      end
      return str_ary_1.join( "\n" )
    end

    str_ary_2 = ::Array.new
    self.to_h.each do | key , value |
      #----
      if ary_keys_in_hash.include?( key )
        str_ary_3 = ::Array.new
        str_ary_3 << " " * indent + key
        str_ary_3 << ""
        str_ary_3 << value.to_strf( indent + 2 )

        str_ary_2 << str_ary_3.join( "\n" )
      else
        str_ary_1 << " " * indent + key.ljust(32) + value.to_s
      end
      #----
    end

    return [ str_ary_1.join( "\n" ) , str_ary_2.join( "\n" * 3 ) ].join( "\n" * 2 )
  end

end