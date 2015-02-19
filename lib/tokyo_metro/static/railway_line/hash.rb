# 複数の路線の情報を扱うクラス（ハッシュ）
class TokyoMetro::Static::RailwayLine::Hash < ::TokyoMetro::Static::Fundamental::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayLine
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Hash

  # 与えられた路線名の文字列から色を取得するメソッド
  # @param str [String] 路線名の文字列
  # @return [::TokyoMetro::Static::Color]
  def select_main_color( str )
    if self.keys.include?( str )
      return self[ str ].color.first
    else
      #---- 末尾が数字の場合 ここから
      if /\A(odpt\.Railway\:[a-zA-Z\-\.]+)\.(\d+?)\Z/ =~ str
        str , num = $1 , $2.to_i
        # 文字列部分が self の key である場合
        if self.keys.include?( str )
          color_info = self[ str ].color
          if color_info.instance_of?( ::Array ) and num <= color_info.length
            return color_info[ num - 1 ]
          end
        end
      end
      #---- 末尾が数字の場合 ここまで
    end
    puts self.keys
    puts ""
    raise "Error: \"#{str}\" is not valid."
  end

end