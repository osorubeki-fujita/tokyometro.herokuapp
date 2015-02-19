class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: true )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "meta_class" )
  end

  def self.other_files
    namespaces.map { | namespace |
      files_starting_with( top_file , namespace )
    }
  end

  class << self

    private

    def namespaces
      [ "fundamental" , "data_search" , "not_real_time" , "real_time" , "geo" , "hybrid" ]
    end

  end

end