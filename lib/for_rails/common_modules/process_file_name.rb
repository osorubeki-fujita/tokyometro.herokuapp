# ファイル名を処理する機能を提供するモジュール
module ForRails::CommonModules::ProcessFileName

  extend ::ActiveSupport::Concern

  module ClassMethods

    private

    def convert_yen_to_slash( str )
      str.gsub( /\// , "\\" )
    end

  end

end