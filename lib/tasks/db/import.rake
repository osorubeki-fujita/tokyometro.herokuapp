namespace :tokyo_metro do
  namespace :db do
    namespace :import do
      namespace :csv do

        desc "Import CSV to SqLite3 file on development environment"
        task :to_sqlite => :environment do
          time_dirname = ::TokyoMetro::Rake.time_dirname( ARGV )

          puts "=" * 64
          puts ""
          commands = ::TokyoMetro::Rake::Rails::Deploy::Heroku::Csv::Command.to_import_to_sqlite( time_dirname )
          puts "-" * 32 + " " + "[Begin] Import Csv Files to SqLite3 (as of #{ time_dirname })"

          open( "| rails db" , "r+" ) do |f|
            commands.each do | command |
              f.puts( command )
            end
          end
          puts ""
          puts "-" * 32 + " " + "[End] Import Csv Files to SqLite3"
          puts ""
        end

        desc "Import CSV to PostgreSql on Heroku"
        task :to_postgresql_on_heroku => :environment do
          time_dirname = ::TokyoMetro::Rake.time_dirname( ARGV )

          puts "=" * 64
          puts ""
          commands = ::TokyoMetro::Rake::Rails::Deploy::Heroku::Csv::Command.to_import_to_postgresql( time_dirname )
          puts "-" * 32 + " " + "[Begin] Import Csv Files to PostgreSql on Heroku (as of #{ time_dirname })"
          puts commands

          open( "| heroku pg:psql" , "r+" ) do |f|
            commands.each do | command |
              f.puts( command )
            end
          end
          puts ""
          puts "-" * 32 + " " + "[End] Import Csv Files to PostgreSql on Heroku"
          puts ""
        end

      end
    end
  end
end