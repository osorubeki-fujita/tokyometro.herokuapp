class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Save::Api < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "save" , "api" )
  end

  def self.other_files
    [
      MetaClass.files ,
      #-------- save_realtime_infos / リアルタイム情報の取得
      ::File.join( top_file , "realtime_infos" )
    ]
  end

end