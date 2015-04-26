namespace :tokyo_metro do
  namespace :db do

    desc "Make list of tables"
    task :make_list_of_tables => :environment do
      ::File.open( "#{ ::Rails.root }/db/tables.txt" , "w:utf-8" ) do |f|
        f.print( ::ActiveRecord::Base.connection.tables.join( "\n" ) )
      end
    end

    namespace :convert do
      namespace :csv do

        desc "Convert CSV file letter code from UTF-8 to Shift-JIS"
        task :to_shift_jis do
          time_dirname = ::TokyoMetro::Rake.time_dirname( ARGV )
          ::TokyoMetro::Rake::Rails::Deploy::Heroku::Csv.convert_to_shift_jis( time_dirname )
        end

      end
    end

  end
end

namespace :db do
  desc "Vacuum db"
  task :vacuum do
    open( "| rails db" , "r+" ) do |f|
      f.puts( "vacuum;" )
      f.puts( ".q" )
    end
  end
end