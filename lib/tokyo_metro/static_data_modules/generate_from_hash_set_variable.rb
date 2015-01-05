# 「ハッシュからインスタンスを作成するときにハッシュの値を取得するメソッド」を提供するモジュール
module TokyoMetro::StaticDataModules::GenerateFromHashSetVariable

  extend ::ActiveSupport::Concern

  module ClassMethods

    private

    # ハッシュからインスタンスを作成するときにハッシュの値を取得するメソッド
    # @param h [Hash] ハッシュ
    # @param key [String or Symbol] ハッシュのキー
    # @param boolean [Boolean] ハッシュ (h) 内のキー (key) に対応する値が boolean か否かの設定
    # @note boolean に true を設定し、ハッシュ (h) 内にキー (key) に対応する値が存在しなかった場合は、false を返す。
    # @return [Object]
    # @return [Boolean] 変数 boolean に true を設定した場合
    def generate_from_hash__set_variable( h , key , boolean: false )
      if h[ key.to_s ].present?
        v = h[ key.to_s ]
      elsif h[ key ].present?
        v = h[ key ]
      else
        if boolean
          v = false
        else
          v = nil
        end
      end
      if boolean and !( v.boolean? )
        raise "Error"
      end
      v
    end

  end

end