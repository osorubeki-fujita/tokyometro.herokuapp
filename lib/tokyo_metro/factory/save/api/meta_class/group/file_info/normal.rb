class TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo::Normal < TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo

  private

  def set_filename_according_to_settings( str )
    str.gsub( /[\/\.]/ , "\/" )
  end

end