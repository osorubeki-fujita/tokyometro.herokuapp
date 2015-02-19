class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api::MetaClass::Timetables < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" , "meta_class" , "timetables" )
  end

  def self.other_files
    [
      files_starting_with( top_file , "train_type_modules" ) ,
      files_starting_with( top_file , "train_type" ) ,
    ]
  end

end