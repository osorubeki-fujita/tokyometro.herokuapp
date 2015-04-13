class TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo::StationTimetable < TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo

  private

  def set_filename_according_to_settings( str )
    str.gsub( /\.(?=[[:alpha:]]+\Z)/ , "_" ).gsub( /[\/\.]/ , "\/" )
  end

end