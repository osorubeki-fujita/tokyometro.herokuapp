require_relative 'fundamental_settings.rb'

::TokyoMetro.set_api_constants( { station_facility: true } )

Dir.glob( "#{File.dirname(__FILE__)}/#{File.basename( __FILE__ , ".*" )}/**/**.rb" ).each do | file |
  require file
end

marunouchi_branch_line
chiyoda_branch_line

escalator_direction_in_otemachi
located_area_of_toilet_in_nakano_shimbashi

replacing_railway_lines