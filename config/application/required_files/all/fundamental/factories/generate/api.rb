class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Generate::Api < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "generate" , "api" )
  end

  def self.other_files
    [
      ::Dir.glob( "#{ top_file }/**.rb" ).sort ,
      MetaClass.files ,
      StationFacility.files
    ]
  end

end