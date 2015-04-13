class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" )
  end

  def self.other_files
    [
      #
      Modules.files ,
      #
      ClassNameLibrary.files ,
      #
      Others.files ,
      Factory.files ,
      App.files ,
      #
      Static.files ,
      Api.files ,
      ApiDecorator.files ,
      Refinement.files
    ]
  end

end