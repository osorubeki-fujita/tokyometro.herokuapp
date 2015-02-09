class TokyoMetro::Document::MakeExamples::Static::EachFile

  def initialize( filename )
    @filename = filename
    ary = open( @filename , "r:utf-8" ).read.split( /\n{3,}/ )

    indent_n , *infos_of_method = ary
    @indent = indent_n.gsub( /\Aindent \: / , "" ).to_i
    @infos_of_method = infos_of_method.map { | info_in_rows |
      variables = info_in_rows.split( /\n+/ )
      EachMethod.new( @indent , *variables )
    }
  end

  def process
    file = ::File.open( filename_of_result , "w:utf-8" )
    file.print( @infos_of_method.map( &:to_s ).join( "\n" * 3 ) )
    file.close
  end

  private

  def filename_of_result
    @filename.gsub( /(?<=make_examples_in_document\/)base\// , "result/" )
  end

end