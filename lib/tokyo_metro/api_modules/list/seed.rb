# DB へのデータ流し込みに関する機能を格納するモジュール
module TokyoMetro::ApiModules::List::Seed

  # 配列の各要素のインスタンスをデータベースに流し込むメソッド
  # @return [nil]
  def seed( indent: 0 , method_name: nil , other: nil )
    if method_name.nil?
      ::TokyoMetro::Seed::Inspection.title( self.class , indent: indent )
    else
      ::TokyoMetro::Seed::Inspection.title_with_method( self.class , method_name , indent: indent , other: other )
    end
    time_begin = Time.now

    if block_given?
      yield
    else
      self.each do |v|
        v.seed
      end
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin , indent: indent )
    return nil
  end

end