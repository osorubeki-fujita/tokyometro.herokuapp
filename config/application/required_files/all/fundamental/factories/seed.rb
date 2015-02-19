class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" )
  end

  def self.other_files
    [
      Reference.files ,
      Common.files ,
      Api.files ,
      Static.files
    ]
  end

end