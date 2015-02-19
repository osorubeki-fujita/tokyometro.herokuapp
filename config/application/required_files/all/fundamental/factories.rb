class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  # factories / Facetory Pattern
  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" )
  end

  def self.other_files
    [
      Generate.files ,
      Get.files ,
      Save.files ,
      Scss.files ,
      YamlStationList.files ,
      Seed.files ,
      Common.files
    ]
  end

end