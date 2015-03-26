module MakeCommands

  # DIR_OF_UTF_8 ="utf_8"
  DIR_OF_UTF_8 ="utf_8_as_of_20150326_1503"
  DIR_OF_SHIFT_JIS ="shift_jis_as_of_20150326_1503"

  def self.process
    Dir.chdir( File.dirname( __FILE__ ) )
    make_command_list_txt_file
  end
  
  private
  
  class << self

    def make_command_list_txt_file
    
      rows_for_importing_to_sqlite = Array.new
      rows_for_exporting_from_sqlite = Array.new
      rows_for_importing_to_postgresql = Array.new
    
      rows_for_importing_to_sqlite << ".separator ,"
    
      rows_for_exporting_from_sqlite << ".mode csv"
      rows_for_exporting_from_sqlite << ".header OFF"
    
      tables = open( "tables.txt" , "r:utf-8" ).read.split( /\n/ )
      tables_without_schema_migrations = tables.delete_if { | table | /\A\#{2} \[Schema migrations\] / =~ table }
    
      # SQLite に import する table
      #   「schema_migrations 以外の table のうち、# で始まるもの」
      tables_imported_to_sqlite_a = tables_without_schema_migrations.select { | table | /\A\#/ === table }.map { | table | table.gsub( /\A\#\s+/ , "" ) }
      #   「schema_migrations 以外の table から、# で始まるものを取り除いたもの」
      tables_imported_to_sqlite_b = tables_without_schema_migrations.select { | table | /\A\#/ !~ table }
      tables_imported_to_sqlite = tables_imported_to_sqlite_b
    
      # SQLite から export する table
      #   「schema_migrations 以外の table から、# で始まるものを取り除いたもの」
      tables_exported_from_sqlite = tables_without_schema_migrations.select { | table | /\A\#/ !~ table }
      
      # PostgreSQL に import する table
      #   原則は「schema_migrations 以外すべて」
      tables_imported_to_postgresql = tables_without_schema_migrations.map { | table | table.gsub( /\A\#\s+/ , "" ) }
      
      tables_imported_to_sqlite.each do | table |
        rows_for_importing_to_sqlite << ".import ./../rails_tokyo_metro_db/csv/#{ DIR_OF_UTF_8 }/#{table}.csv #{table}"
      end
    
      tables_exported_from_sqlite.each do | table |
        rows_for_exporting_from_sqlite << ".output ./../rails_tokyo_metro_db/csv/#{ DIR_OF_UTF_8 }/#{table}.csv"
        rows_for_exporting_from_sqlite << "select * from #{table};"
      end
    
      tables_imported_to_postgresql.each do | table |
        rows_for_importing_to_postgresql << "\\copy #{ table } from \'\./../rails_tokyo_metro_db/csv/#{ DIR_OF_SHIFT_JIS }/#{ table }.csv\' CSV ;"
      end
    
      open( "commands_for_importing_to_sqlite.txt" , "w:utf-8" ) do |f|
        f.print rows_for_importing_to_sqlite.join( "\n" )
      end
    
      open( "commands_for_exporting_from_sqlite.txt" , "w:utf-8" ) do |f|
        f.print rows_for_exporting_from_sqlite.join( "\n" )
      end
      
      open( "commands_for_importing_to_postgresql.txt" , "w:utf-8" ) do |f|
        f.print rows_for_importing_to_postgresql.join( "\n" )
      end
    end
  
  end

end