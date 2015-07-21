module RealTimeInfoProcessor

  private

  def set_real_time_info_processor( railway_line_infos: @railway_line_infos )
    @real_time_info_processor = ::TokyoMetro::App::Renderer::RealTimeInfos.new( request , railway_line_infos )
  end

end
