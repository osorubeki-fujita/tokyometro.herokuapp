class TokyoMetro::Factory::Seed::Common::Group

  include ::TokyoMetro::Factory::Seed::Common::SetOptionalVariables
  include ::OdptCommon::CalcTime

  def initialize( *args , class_name , method_name , indent , no_display , not_on_the_top_layer , display_number , other_info , interrupt )
    if no_display and display_number
      raise "Error: Do you want to display number? You set both of \'no_display\' and \'display_number\'."
    end
    @class_name = class_name
    @method_name = method_name
    @indent = indent
    @no_display = no_display
    @not_on_the_top_layer = not_on_the_top_layer
    @display_number = display_number
    @other_info = other_info

    @interrupt = interrupt

    set_optional_variables( args )
  end

  def self.process( *variables )
    self.new( *variables ).seed
  end

  private

  def inspection
    inspect_title
    @time_begin = ::Time.now

    yield

    inspect_time
  end

  def inspect_title
    unless @no_display
      if @not_on_the_top_layer
        puts ""
      end
      puts title_for_inspection
      puts ""
    end
  end

  def title_for_inspection
    str = ::String.new
    str << " " * @indent * 4
    unless @not_on_the_top_layer
      str << "●"
    else
      str << "○"
    end
    str << " #{ @class_name }\##{ @method_name }"
    if @other_info.present?
      str << " #{ @other_info }"
    end

    str
  end

  def display_number( item , now_at )
    if @display_number
      str = ::String.new
      now_at_to_s = now_at.to_s.rjust( whole.to_s.length )
      str << " " * ( @indent + 1 ) * 4 + " \[#{ now_at_to_s }/#{ whole }\]"
      if item.methods.include?( :same_as )
        str << " " + item.same_as
      elsif item.methods.include?( :id_urn )
        str << " " + item.id_urn
      end
      puts str
    end
  end

  def inspect_time
    unless @no_display
      @time_end = ::Time.now
      t = calc_time( @time_begin , @time_end )
      puts ""
      puts " " * @indent * 4 + "*" + "#{ t.to_s.rjust(8) } sec / End: #{ @time_end.to_s }"
      puts ""
    end
  end

  def whole
    @array_to_seed.length
  end

  def set_optional_variables( args )
    nil
  end

  def seed_optional_infos
    nil
  end

  def interruption
    if @interrupt
      ::TokyoMetro::Factory::Seed::Common::Interruption.start!
    end
  end

end