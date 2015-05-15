namespace :tokyo_metro do
  namespace :db do

    desc "Make list of tables"
    task :make_list_of_tables => :environment do
      ::File.open( "#{ ::Rails.root }/db/tables.txt" , "w:utf-8" ) do |f|
        f.print( ::ActiveRecord::Base.connection.tables.sort.join( "\n" ) )
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

__END__

rake tokyo_metro:db:deploy:heroku:make_migration_file
rake db:vacuum
rake assets:precompile --trace

rake tokyo_metro:db:export:sqlite:to_csv
rake tokyo_metro:db:convert:csv:to_shift_jis 20150515235244

cap git:commit
git push github master
git push heroku master

rake tokyo_metro:db:deploy:heroku:reset
rake tokyo_metro:db:deploy:heroku:migrate
rake tokyo_metro:db:import:csv:to_postgresql_on_heroku 20150515225626
rake tokyo_metro:db:deploy:heroku:move_migration_files_after_process