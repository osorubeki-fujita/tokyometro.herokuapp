namespace :tokyo_metro do
  namespace :process do

    desc "駅番号ファイルの名称の変更・移動"
    task :station_number_image_files do

      Dir.chdir( "#{ ::Rails.root }/app/assets/images/provided_by_tokyo_metro" ) do
        Dir.glob( "station_number/**/**.png" ).each do |f|
          arr = f.split( /\// )
          top_dir , filename = arr[0] , arr[-1]
          regexp = /\Astation_icon_([a-z]{1,2})-(\d{2})[_-].+(\.png)\Z/
          if regexp === filename
            filename_new = filename.gsub( regexp ) { "#{$1}#{$2}#{$3}" }
            puts top_dir + " / " + filename
            puts filename_new
            puts ""
            File.rename( f , "#{top_dir}\/#{filename_new}" )
          end
        end
      end

    end

    desc "列車ロケーション情報のファイル名の変換"
    task :train_location_files do
      require 'fileutils'
      ::Dir.chdir( "#{ ::TokyoMetro::DB_DIR }/train_location/2014" )
      files = ::Dir.glob( "1007/TokyoMetro/**/**.json" ).select { | filename | /0[012]\d{4}.json\Z/ === filename }
      puts files.length

      files.each do | file |
        old_filename = file
        ary_of_dir_and_file = file.split( "/" )
        unless ary_of_dir_and_file.length == 4
          raise "Error"
        end

        ary_of_dir_and_file[0] = sprintf( "%4.4d" , ary_of_dir_and_file.first.to_i - 1 )
        ary_of_dir_and_file[3] = sprintf( "%6.6d" , ary_of_dir_and_file[3].to_i + 240000 ) + ".json"
        new_filename = ary_of_dir_and_file.join("/")

        ::FileUtils.mkdir_p( ::File.dirname( new_filename ) )
        ::File.rename( old_filename , new_filename )
        puts new_filename
      end

    end

    desc "CSV ファイルの文字コードの変換"
    task :db_csv_files do
      require_relative( "#{File.dirname( __FILE__ ) }/../../../db/csv/convert_csv_letter_codes.rb" )
      ::ConvertCsvLetterCode.process
    end

  end
end