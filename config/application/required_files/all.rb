class RailsTokyoMetro::Application::RequiredFiles::All < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" )
  end

  def self.other_files
    [
      # 組み込みライブラリの拡張、共通して使用するモジュールなど
      ForRails.files ,
      #
      Fundamental.files
    ]
  end

  def self.files
    _files = self.new.files
    display_files_not_be_required
    output_required_files

    return _files
  end

  class << self

    private

    def display_files_not_be_required
      _files_not_be_required = files_not_be_required
      if _files_not_be_required.present?
        puts "● These files will not be required."
        puts _files_not_be_required.map { | str | str + ".rb" }
        puts ""
      end
    end

    def output_required_files
      _required_files = required_files.map { | str | str.gsub( "#{ ::Rails.root.to_s }/" , "" ) + ".rb" }
      open( "#{ ::Rails.root }/required_files.txt" , "w:utf-8" ) do |f|
        f.print _required_files.join( "\n" )
      end
    end

  end

end