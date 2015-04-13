class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Generate::Static::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "generate" , "static" , "meta_class" )
  end

  def self.other_files
    Group.files
  end

end