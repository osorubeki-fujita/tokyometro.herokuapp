class TokyoMetro::Document::MakeExamples::Static::EachFile::EachMethod

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
    # puts ""
    # puts code_for_making_example

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

  def results
    # puts actual_code_for_making_example
    return eval( actual_code_for_making_example )
  end

  def actual_code_for_making_example
    str = <<-CODE
      #{@hash_const}.values.map { | #{@value_in_block} |
        " " * @indent + "\#   " + #{evaluated_string}
      }
    CODE

    return str
  end

  def evaluated_string
    @displayed.split( / \+ / ).map { | str |
      code = <<-CODE
        Proc.new { | #{@value_in_block} |
        if #{str} == nil
          "\(nil\)"
        elsif #{str} == ""
          "（空文字列）"
        # elsif #{str}.instance_of?( ::String )
          # "\\\"" + #{str} + "\\\""
        else
          #{str}.to_s
        end
        }.call( #{@value_in_block} )
        CODE
      code.gsub( /\n *\Z/ , "" )
    }.join( " + " )
  end

end