require_relative 'fundamental_settings.rb'

::TokyoMetro.set_api_constants( { railway_line: true } )

Dir.glob( "#{File.dirname(__FILE__)}/#{File.basename( __FILE__ , ".*" )}/**/**.rb" ).each do | file |
  require file
end

chiyoda_branch_line
marunouchi_branch_line