# 駅の情報（他社線も含む）を扱うクラスのハッシュ (default) を作成するための Factory クラス (2)
class TokyoMetro::Factories::StaticDatas::Station < TokyoMetro::Factories::StaticDatas::MetaClass::MultipleYamls

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Station

  # Constructor
  def initialize( railway_lines )
    @railway_lines = railway_lines
  end

  private

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Proc]
  # @note {TokyoMetro::Factories::StaticDatas::MetaClass::MultipleYamls#generate_procedure} とはロジックが異なることに注意
  def generate_procedure( h_new )
    @railway_lines.each do | railway_line , filename |
      h_new[ railway_line ] = self.class.factory_for_each_file.from_yaml( filename )
    end
    h_new
  end

end