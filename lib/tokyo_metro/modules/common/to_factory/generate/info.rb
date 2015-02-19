# 保存済みの情報を処理するメソッドを提供するモジュール
module TokyoMetro::Modules::Common::ToFactory::Generate::Info

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (2) - データの取得・保存
    # である Hash からインスタンスを作成するメソッド
    # 与えられた Hash からインスタンスを作成するメソッド
    # @param variables [::Hash] API からのデータを処理する場合 … 変数は1つ。API から取得した JSON をパースして得られた配列の要素。
    # @param variables [::Array] Static なデータを処理する場合 … 変数は2つ。第1変数は作成するインスタンスの ID キー。第2変数は YAML をパースして得られた配列の要素。
    # @return [Info]
    def generate_from_hash( *variables )
      #puts "method for factory: #{factory_name.to_s}"
      #puts "factory: #{self.send( factory_name ).to_s}"
      #puts __FILE__
      #puts ""
      factory_for_this_class.process( *variables )
    end

    def factory_for_this_class
      factory_for_generating_from_hash
    end

  end

end