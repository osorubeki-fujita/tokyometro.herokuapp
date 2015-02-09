class TokyoMetro::Factories::Save::Api::MetaClass::Group::FileInfo::Normal < TokyoMetro::Factories::Save::Api::MetaClass::Group::FileInfo

  private

  def set_filename_according_to_settings( str )
    str.gsub( /[\/\.]/ , "\/" )
  end

end