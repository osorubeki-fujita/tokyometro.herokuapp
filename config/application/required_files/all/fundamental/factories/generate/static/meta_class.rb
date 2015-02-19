class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Generate::Static::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "generate" , "static" , "meta_class" )
  end

  def self.other_files
    Group.files
  end

end