namespace :tokyo_metro do
  namespace :make do
    desc "ドキュメント生成に関するファイルのロード"
    task :load_scripts_related_to_document do
      require 'fileutils'
      load 'C:/Users/Fujita Shu/Dropbox/Program/Ruby/common_settings.rb'
      load "#{ ::Rails.root }/lib/tokyo_metro.rb"
      load "#{ ::Rails.root }/lib/tokyo_metro/document.rb"
      Dir.glob( "#{ ::Rails.root }/lib/tokyo_metro/document/**/**.rb" ).sort.each do | file |
        load file
      end
    end

    desc "YARD によるドキュメント生成"
    task :document => :load_scripts_related_to_document do
      ::TokyoMetro::Document.yard( verbose: true )
    end

    namespace :gviz do
      desc "Ruby のクラス図の生成"
      task :ruby_graph => :load_scripts_related_to_document do
        ::TokyoMetro::Document::Gviz::RubyGraph.process
      end

      desc "ファイルの階層図の生成"
      task :dir_graph => :load_scripts_related_to_document do
        ::TokyoMetro::Document::Gviz::DirGraph.process( dot_files: true , db_dot_files: true )
      end

      desc "画像ファイルの生成（dot ファイルを変換）"
      task :convert_images => :load_scripts_related_to_document do
        ::TokyoMetro::Document::Gviz::ConvertToImage.process( include_ruby_classes: false )
      end
    end

    namespace :examples do
      desc "ドキュメント内で使用する例の作成"
      task :static => :load do
        ::TokyoMetro.set_fundamental_constants
        ::TokyoMetro::Document::MakeExamples::Static.process
      end
    end

    namespace :scss do
      desc "SCSSファイルの生成 - 鉄道事業者の色"
      task :operators => :load do
        ::TokyoMetro::Static.operators.make_scss_color_file
      end
      desc "SCSSファイルの生成 - 路線の色"
      task :railway_lines => :load do
        ::TokyoMetro::Static.railway_lines.make_scss_color_file
      end
      desc "SCSSファイルの生成 - 列車種別の色"
      task :train_types => :load do
        ::TokyoMetro::Static.train_types.make_scss_color_file
      end
    end

    desc "駅名辞書の生成 (YAML <- CSV)"
    task :yaml_station_list => :load do
      ::TokyoMetro::Factory::YamlStationList.process
    end
    
    desc "Static Example の作成"
    task :static_examples => :load do
      ::TokyoMetro::Document::MakeExamples::Static.process
    end
    
    desc  "DB の import, export に関するコマンドの一括作成"
    task :commands_for_db do
      require_relative( "#{ File.dirname( __FILE__ ) }/../../../db/csv/make_commands.rb" )
      MakeCommands.process
    end

  end
end