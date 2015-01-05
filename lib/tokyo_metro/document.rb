# ドキュメントの生成に関する機能を格納する名前空間
module TokyoMetro::Document

  # YARD によるドキュメントを生成するメソッド
  # @return [nil]
  def self.yard( verbose: true )
    Dir.chdir( "#{ ::Rails.root }/app" )
    ::MakeYardoc::process( make_yardoc: true , copy_css: true , files: "**\\**.rb" , title: title_default( "\[app\]" ) , verbose: verbose , embed_mixins: true )
    Dir.chdir( "#{ ::Rails.root }/lib" )
    ::MakeYardoc::process( make_yardoc: true , copy_css: true , files: "**\\**.rb" , title: title_default( "\[lib\]" ) , verbose: verbose , embed_mixins: true )
  end

  class << self

    private

    def title_default( addition = nil )
      str = ::String.new
      str << "Ruby for Rails"
      str << " - "
      if addition.blank?
        str << "Web programming"
      else
        str << addition
      end
      str << " "
      time = ::Time.now.strftime( "%Y.%m.%d %H:%M" )
      str << "(as of #{ time })"
      str
    end
  end

end

__END__

    dirname_where_yardoc_files_are_moved_to = "#{ File.dirname( __FILE__ ) }/yardoc"
    preserve_file_info = true

    # 移動の対象となるファイル
    files_to_be_moved = Dir.( "doc/

    Dir.glob( "doc/**/*.*" ).sort.each do | file |
      filename_base = file.gsub( /\Adoc\// , "" )
      filename_n = "#{ dirname_where_yardoc_files_are_moved_to }/#{ filename_base }"
      ::FileUtils.mkdir_p( File.dirname( filename_n ) )
      unless file == "./doc/css/custom/custom.css"
        File.rename( file , filename_n )
      else
        # 3番目の引数 preserve_file_info が真のときは、更新時刻と（可能なら）所有ユーザ・所有グループもコピー
        ::FileUtils.copy_file( file , filename_n , preserve_file_info )
      end
    end