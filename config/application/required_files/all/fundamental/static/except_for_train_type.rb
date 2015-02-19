class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Static::ExceptForTrainType < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "static" )
  end

  def self.other_files
    namespaces.map { | namespace |
      files_starting_with( top_file , namespace )
    }
  end

  class << self

    private

    def namespaces
      [
        "fundamental" ,
        "fare" , "color" , "operator" , "station" ,
        "railway_direction" , "railway_line" , "stations_in_tokyo_metro" , "stopping_pattern" , "train_owner" ,
        "operation_day" , "train_information_status"
      ] - [
        "stopping_pattern"
      ]
    end

  end

end