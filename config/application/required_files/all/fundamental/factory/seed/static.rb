class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Static < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "static" )
  end

  def self.other_files
    [
      MetaClass.files ,
      Operator.files ,
      RailwayLine.files ,
      Station.files
    ]
  end

end