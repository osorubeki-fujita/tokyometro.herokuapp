# ハッシュ (Hash) のクラスに組み込むモジュール
module ForRails::ExtendBuiltinLibraries::HashModule

  def sort_keys
    h = ::Hash.new
    self.keys.sort.each do | key |
      h[ key ] = self[ key ]
    end
    h
  end

end