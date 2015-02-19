class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Static < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "static" )
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