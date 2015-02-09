# 列車種別の情報に関する SCSS の color ファイルを作成・処理するための Factory Pattern Class
class TokyoMetro::Factories::Scss::TrainTypes::Colors < TokyoMetro::Factories::Scss::Colors

  include ::TokyoMetro::Factories::Scss::TrainTypes::DirnameSettings

  # インポートするファイルのリスト
  # @return [::Array <String>]
  def self.imported_files
    [ "../common_mixins/rounded_square" , "odakyu_romance_car" ]
  end

  # 色の設定（具体的な SCSS コード）に include する mixin のリスト
  # @return [::Array <String>]
  def self.included_bg_mixins
    [ "rounded_square_wide" ]
  end

  # SCSS ファイルを作成する際の設定
  # @return [Hash]
  def self.settings_of_method_name
    { color: :web_color , bgcolor: :bg_web_color }
  end

  private

  # include する mixin を文字列の配列に追加するメソッド
  # @return [nil]
  def generate_file__content_for_each_color__add_included_info_to_str_ary( str_ary , info )
    # puts info.same_as
    # if /\Acustom\.TrainType\:TokyoMetro\.Chiyoda\.RomanceCar/ === info.same_as
    #   str_ary << "  \@include odakyu_romance_car \;"
    # else
      super( str_ary , info )
    # end
  end

end