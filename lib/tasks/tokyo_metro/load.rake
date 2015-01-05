namespace :tokyo_metro do
  desc "ロードするファイルのリストのリセット"
  task :reset_load_files do
    system( "rails console" )
  end
  
  desc "lib ディレクトリ配下のファイルのロード"
  task :load do
    open( "#{ ::Rails.root }/required_files.txt" , "r:utf-8" ).read.split( /\n/ ).each do |f|
      require f
    end
    ::TokyoMetro.extend_builtin_libraries
    ::TokyoMetro.set_modules
  end
end