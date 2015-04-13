class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::TransferInfos < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::MetaClass

  def set_proc_for_dicision
    @proc_for_dicision = ::Proc.new { | infos | infos.map( &:to_array_of_displayed_infos ) }
  end

end