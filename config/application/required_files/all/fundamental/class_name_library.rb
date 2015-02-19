class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::ClassNameLibrary < RailsTokyoMetro::Application::RequiredFiles

  # class_name_library / クラス名のライブラリ
  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "class_name_library" )
  end

  def self.other_files
    Api.files
  end

end