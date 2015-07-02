namespace :tokyo_metro do
  namespace :db do
  
    namespace :make do

      desc "Make list of tables"
      task :list_of_tables => :environment do
        ::File.open( "#{ ::Rails.root }/db/tables.txt" , "w:utf-8" ) do |f|
          f.print( ::ActiveRecord::Base.connection.tables.sort.join( "\n" ) )
        end
      end

      namespace :list_of_commands do
        namespace :for_importing do
          namespace :csv do

            desc "Make commands for importing csv to PostgrSql on Heroku"
            task :to_postgresql_on_heroku => :environment do
              time_dirname = ::TokyoMetro::Rake.time_dirname( ARGV )
              commands = ::TokyoMetro::Rake::Rails::Deploy::Heroku::Csv::Command.to_import_to_postgresql( time_dirname )
              ::File.open( "#{ ::Rails.root }/db/csv/#{time_dirname}/commands_for_importing_csv_to_postgresql_on_heroku.txt" , "w:utf-8" ) do |f|
                f.print( "heroku pg:psql" )
                f.print( "\n" )
                f.print( commands.join( "\n" ) )
                f.print( "\n" )
                f.print( "\\q" )
                f.print( "\n" )
              end
            end

          end
        end
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

cap git:commit
git push github master

rake assets:precompile --trace # （省略可）
rake tokyo_metro:db:deploy:heroku:move_migration_files_after_process
rake tokyo_metro:db:make:list_of_tables
rake tokyo_metro:db:deploy:heroku:make_migration_file
rake db:vacuum

cap git:commit

rake tokyo_metro:db:export:sqlite:to_csv
rake tokyo_metro:db:convert:csv:to_shift_jis 20150604033506

#---- importing commands
rake tokyo_metro:db:make:list_of_commands:for_importing:csv:to_postgresql_on_heroku 20150604033506

heroku maintenance:on

git push heroku master
rake tokyo_metro:db:deploy:heroku:reset
rake tokyo_metro:db:deploy:heroku:migrate

#---- importing process
# rake tokyo_metro:db:import:csv:to_postgresql_on_heroku 20150604033506

heroku maintenance:off
rake tokyo_metro:db:deploy:heroku:move_migration_files_after_process

cap git:commit
git push github master