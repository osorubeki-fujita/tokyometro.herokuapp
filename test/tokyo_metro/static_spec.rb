require_relative 'fundamental_settings.rb'

Dir.glob( "#{File.dirname(__FILE__)}/#{File.basename( __FILE__ , ".*" )}/**/**.rb" ).each do | file |
  require file
end

station
railway_lines
train_type