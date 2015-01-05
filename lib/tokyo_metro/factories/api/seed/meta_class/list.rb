
__END__

class TokyoMetro::Factories::Api::Seed::MetaClass::List

  def self.process( infos )
    infos.each do | info |
      info.seed_class.seed
    end
  end

end