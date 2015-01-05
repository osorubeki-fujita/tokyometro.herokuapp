# ファイルの階層図を生成するためのモジュール
module TokyoMetro::Document::Gviz::DirGraph

  # 処理を行うメソッド
  # @param dot_files [Boolean] .dot ファイルの生成を行うか否かの設定
  # @return [nil]
  def self.process( dot_files: true , db_dot_files: true )
    if dot_files
      make_dot_files
    end
    if db_dot_files
      make_db_dot_files
    end
    return nil
  end

  class << self

    private

    # .dot ファイル（ディレクトリ "ruby" と "public" ）を生成するメソッド
    # @return [nil]
    def make_dot_files
      Dir.chdir( ::Rails.root ) do
        [ "app" , "lib" ].each do | dirname |
          make_dot_by_dir_friend( dirname )
        end
      end
      return nil
    end

    # .dot ファイル（ディレクトリ "db" ）を生成するメソッド
    # @return [nil]
    def make_db_dot_files
      Dir.chdir( ::TokyoMetro::DB_DIR ) do
        dirs = [
          "csv" , "dictionary" , "fare" , "point" , "passenger_survey" , "railway_line" ,
          "station" , "station_facility" , "station_timetable" , "train_information" , "train_location" , "train_timetable"
        ]
        exceptions = [ "fare" , "train_information" , "train_location" , "train_timetable" ]
        ( dirs - exceptions ).each do | db_dirname |
          make_dot_by_dir_friend( db_dirname , add_db: true )
        end
      end
      return nil
    end

    def make_dot_by_dir_friend( dirname , add_db: false )
      default_dot_filename = "a.dot"
      FileUtils.mkdir_p( ::TokyoMetro::Document::Gviz::DIRNAME )

      system( "dir_friend dot #{dirname} -c blues --dir_shape box --file_shape box -g \"splines:ortho\"" )

      if add_db
        filename_new = "db_#{dirname}"
      elsif dirname == "ruby"
        filename_new = "ruby_files"
      elsif dirname == "lib"
        filename_new = "ruby_lib"
      else
        filename_new = dirname
      end
      File.rename( default_dot_filename , "#{ ::TokyoMetro::Document::Gviz::DIRNAME }/#{filename_new}.dot" )
    end

  end

end