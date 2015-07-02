namespace :tokyo_metro do
  namespace :db do
    namespace :export do
      namespace :sqlite do

        desc "Export SqLite3 file on development environment to CSV"
        # :environment は モデルにアクセスするのに必須
        task :to_csv => :environment do
          # system( "heroku run bundle exec rake RAILS_ENV=production db:data:load --app tokyometro" )
          puts "=" * 64
          puts ""
          commands = ::TokyoMetro::Rake::Rails::Deploy::Heroku::Csv::Command.to_export_from_sqlite
          puts "-" * 32 + " " + "[Begin] Export SqLite3 to Csv Files"

          open( "| rails db" , "r+" ) do |f|
            commands.each do | command |
              f.puts( command )
            end
          end
          puts ""
          puts "-" * 32 + " " + "[End] Export SqLite3 to Csv Files"
          puts ""
        end

      end
    end
  end
end