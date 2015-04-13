class TokyoMetro::Factory::Generate::Static::MetaClass::Group::HashInHash::EachFile < TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls::EachFile

  private

  def generating_procedure( d_yaml )
    raise "Error" unless d_yaml.instance_of?( ::Hash )
    h_new = self.class.hash_class_for_this_factory.new

    d_yaml.each_with_index do | ( key , value ) , i |
      h_new[ key ] = self.class.info_class.generate_from_hash( key , value , i )
    end

    h_new
  end

  def self.hash_class_for_this_factory
    subhash_class
  end

end