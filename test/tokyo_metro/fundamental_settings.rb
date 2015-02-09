require 'active_support/core_ext'
require 'active_support/concern'
require 'moji'

open( "#{ ::File.dirname( __FILE__ ) }/../../required_files.txt" , "r:utf-8" ).read.split( /\n/ ).each do |f|
  require "#{ ::File.dirname( __FILE__ ) }/../../#{f}"
end

#---------------- 標準添付ライブラリの拡張
::TokyoMetro.extend_builtin_libraries

#---------------- モジュールの組み込み
::TokyoMetro.set_modules

#---------------- 定数のセット
::TokyoMetro.set_fundamental_constants