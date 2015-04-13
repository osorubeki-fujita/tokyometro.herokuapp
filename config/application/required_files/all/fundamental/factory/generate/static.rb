class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Generate::Static < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "generate" , "static" )
  end

  def self.other_files
    [
      MetaClass.files ,
      Color.files ,
      TrainType.files
    ]
  end

end