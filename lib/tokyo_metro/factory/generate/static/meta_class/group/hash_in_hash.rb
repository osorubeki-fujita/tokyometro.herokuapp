# 各種ハッシュを作成するための Factory クラス - 3.1 複数の YAML ファイルから、「ハッシュを値とするハッシュ」を作成
class TokyoMetro::Factory::Generate::Static::MetaClass::Group::HashInHash < TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls

  # Constructor
  # @param h [::Hash]
  def initialize(h)
    raise "Error" unless h.instance_of?( ::Hash )
    @h = h
  end

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Hash]
  # @note {TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls#generating_procedure} とはロジックが異なることに注意
  def generating_procedure( h_new )
    @h.each do | key , filename |
      h_new[ key ] = self.class.factory_for_generating_from_each_saved_file.from_yaml( filename )
    end
    h_new
  end

end