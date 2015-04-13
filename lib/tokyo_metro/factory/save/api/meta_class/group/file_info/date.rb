class TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo::Date < TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo

  private

  def set_filename_according_to_settings( str )
    date_info = @list.first[ "dc:date" ]
    @datetime = ::DateTime.parse( date_info )

    "#{str_y_md}/#{str}/#{str_h}#{str_ms}"
  end

  def str_y_md
    format_str = "%Y\/%m%d"
    if before_change_date?
      @datetime.prev_day.strftime( format_str )
    else
      @datetime.strftime( format_str )
    end
  end

  def str_h
    if before_change_date?
      date_str_h = ( @datetime.hour + 24 ).to_s
    else
      date_str_h = @datetime.hour.to_s
    end
  end

  def str_ms
    date_str_ms = datetime.strftime( "%M%S" )
  end

  def before_change_date?
    @datetime.hour < ::TokyoMetro::CHANGE_DATE
  end

end