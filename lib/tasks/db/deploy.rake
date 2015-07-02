namespace :tokyo_metro do
  namespace :db do
    namespace :deploy do
      namespace :heroku do

        # ディレクトリ migrate にファイルが存在する場合に、db:migrate を実行し、.rb ファイルを移動
        # @note
        #   ファイル名が heroku_initializer.rb で終わる場合はディレクトリ migrate_heroku_old へ移動
        #   それ以外の場合はディレクトリ migrate_tmp へ移動
        desc "Move migration files before Heroku process"
        task :move_migration_files_before_process do
          ::TokyoMetro::Rake::Rails::Deploy::Heroku.process_migration_files
          ::TokyoMetro::Rake::Rails::Deploy::Heroku.move_migration_files_to_old_dir
        end

        # Heroku で実行する migration ファイルを作成
        desc "make migration file for Heroku"
        task :make_migration_file => :move_migration_files_before_process do
          ::TokyoMetro::Rake::Rails::Deploy::Heroku.make_migration_file
        end

        # Heroku で実行する（した） migration ファイルをディレクトリ migrate_heroku_old に移動
        desc "Move migration files after Heroku process"
        task :move_migration_files_after_process do
          ::TokyoMetro::Rake::Rails::Deploy::Heroku.move_heroku_migration_files_to_old_dir
        end

        desc "Reset Db on Heroku"
        task :reset do
          system( "heroku pg:reset DATABASE_URL --confirm tokyometro" )
        end

        desc "Migrate Db on Heroku"
        task :migrate => :environment do
          system( "heroku run bundle exec rake RAILS_ENV=production db:migrate" )
          # system( "heroku run rake db:migrate" )
        end

        namespace :schema do

          desc "Rest Db by schema file"
          task :load do
            system( "heroku run bundle exec rake RAILS_ENV=production db:schema:load --app tokyometro" )
            # system( "heroku run rake db:schema:load --app tokyometro" )
          end

        end

      end
    end
  end
end