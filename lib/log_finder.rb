class LogFinder

  def initialize( filename , read_length , number_of_lines )
    @filename = filename
    @read_length = read_length
    @number_of_lines = number_of_lines

    set_array
  end

  def search_by( regexp )
    @search_by = regexp
    n = row_number
    unless n.nil?
      puts @ary[ ( n - 10 )..( n + 100 ) ]
      puts ""
      puts "=" * 64
      puts "displayed from \##{ n - 10 + 1 } to \##{ n + 100 * 1 }"
    else
      puts "No row matched with #{ @search_by }"
    end
  end

  def self.search_by(
    regexp ,
    filename: "C:/RubyPj/Rails/tokyo_metro/log/development.log" ,
    read_length: 256 * 1024 ,
    number_of_lines: nil
  )
    self.new( filename , read_length , number_of_lines ).search_by( regexp )
  end

  private

  #--------

  def set_array
    @ary = []
    f = File.open( @filename , "r:utf-8" )
    begin
      f.seek( - @read_length , ::IO::SEEK_END )
    rescue
    end

    set_each_row_to_array(f)
    f.close
    # ary[ ary.length - line ]
  end

  def set_each_row_to_array(f)
    str = ""
    i = 0
    while to_read_next_line?( str , i )
      str = f.gets
      i += 1
      @ary << str
    end
  end

  def to_read_next_line?( str , i )
    !( at_end_of_the_file?( str ) ) and ( !( number_of_files_is_limitted? ) or ( number_of_files_is_limitted? and i < @number_of_lines ) )
  end

  def at_end_of_the_file?( str )
    str.nil?
  end

  def number_of_files_is_limitted?
    !( @number_of_lines.nil? )
  end

  #--------

  def row_number
    n = nil
    @ary.each_with_index do | row , i |
      if @search_by === row
        n = i
        break
      end
    end
    return n
  end

end
