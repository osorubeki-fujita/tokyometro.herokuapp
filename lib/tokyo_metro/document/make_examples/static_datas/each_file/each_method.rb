class TokyoMetro::Document::MakeExamples::StaticDatas::EachFile::EachMethod

  def initialize ( indent , title , h , value_in_block , displayed )
    @indent = indent
    @title = title
    @hash_const = h.gsub( /\Ahash \: / , "" )
    @value_in_block = value_in_block.gsub( /\Avalue in block \: / , "" )
    @displayed = displayed.gsub( /\Adisplayed \: / , "" )
  end

  def to_s
    puts ""
    puts @title
    puts ""
    puts code_for_making_example
    # puts ""
    # puts actual_code_for_making_example
    [ top , results ].join( "\n" )
  end

  private

  def top
    ary = ::Array.new
    ary << @title
    [ "\# \@example" , "\#   #{code_to_output}" , "\#   \=\>" ].each do | row |
      ary << ( " " * @indent + row )
    end
    ary.join( "\n" )
  end

  def code_to_output
    "#{@hash_const}.each_value { | #{@value_in_block} | puts #{@displayed} }"
  end

  def code_for_making_example
    "#{@hash_const}.values.map { | #{@value_in_block} | #{@displayed} }"
  end

  def actual_code_for_making_example
    str = ::String.new
    str << "#{@hash_const}.values.map \{ | #{@value_in_block} | \;"
    str << " #{evaluated_string}"
    str << " \}"
    str
  end

  def evaluated_string
    @displayed.split( / \+ / ).map { | str |
      [ "if (#{str}) == nil" ,
        "\"\(nil\)\"" ,
        "elsif (#{str}) == \"\"" ,
        "\"（空文字列）\"" ,
        "else" ,
        "#{str}.to_s" ,
        "end"
      ].join( " \; " )
    }.join( " + " )
  end

  def displayed_results
    results.map { | element |
      if element.nil?
        str = "(nil)"
      elsif element.instance_of?( ::String )
        str = "\"#{str}\""
      else
        str = element.to_s
      end
      " " * indent_n + "\#   #{str}"
    }
  end

  def results
    eval( actual_code_for_making_example )
  end

end