# 保存済みの情報を処理するメソッドを提供するモジュール
module TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (2) - データの取得・保存

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッド
    # @param h [Transfer] JSON をパースして得られた配列の要素
    # @return [Info]
    def generate_from_hash( h , factory_name: :factory_for_generating_from_hash )
      #puts "method for factory: #{factory_name.to_s}"
      #puts "factory: #{self.send( factory_name ).to_s}"
      #puts __FILE__
      #puts ""
      self.send( factory_name ).process(h)
    end

  end

end