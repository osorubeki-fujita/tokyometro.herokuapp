class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::BarrierFreeFacilityInfos < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::MetaClass

  def set_proc_for_display
    @proc_for_display = ::Proc.new { | info | info.decorate.render_in_platform_info }
  end

end