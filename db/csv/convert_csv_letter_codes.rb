require 'fileutils'

module ConvertCsvLetterCode
  DIR_OF_UTF_8 ="utf_8_as_of_20150326_1503"
  DIR_OF_SHIFT_JIS ="shift_jis_as_of_20150326_1503"

  def self.process
    Dir.chdir( File.dirname( __FILE__ ) )
    convert_csv_letter_code
  end
  
  class << self
    
    private
    
    def convert_csv_letter_code
      dirname_base = "../../../rails_tokyo_metro_db/csv"
      Dir.glob( "#{dirname_base}/#{ DIR_OF_UTF_8 }/**.csv" ).each do | csv_filename |
        puts csv_filename
        contents = open( csv_filename , "r:utf-8" ).read.split( "\n" )
        if contents.present?
          kojimachi_regexp = /麴町/
          contents = contents.map { | str |
            if kojimachi_regexp =~ str
              str.gsub( kojimachi_regexp , "麹町" ).encode( "windows-31j" )
            else
              str.encode( "windows-31j" )
            end
          }.join( "\n" )
          csv_new_filename = csv_filename.gsub( "#{dirname_base}/#{ DIR_OF_UTF_8 }/" , "#{dirname_base}/#{ DIR_OF_SHIFT_JIS }/" )
          FileUtils.mkdir_p( File.dirname( csv_new_filename ) )
          puts csv_new_filename
          File.open( csv_new_filename , "w:windows-31j" ) do |f|
            f.print( contents )
          end
        end
        puts ""
      end
    end

  end
  
end