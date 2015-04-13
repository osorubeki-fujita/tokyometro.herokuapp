class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  # factory / Facetory Pattern
  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" )
  end

  def self.other_files
    [
      Generate.files ,
      Get.files ,
      Save.files ,
      Scss.files ,
      YamlStationList.files ,
      Seed.files ,
      Common.files ,
      Decorate.files
    ]
  end

end