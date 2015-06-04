module RealTimeInfoProcessor

  private

  def set_real_time_info_processor( railway_lines: @railway_lines )
    @real_time_info_processor = ::TokyoMetro::App::Renderer::RealTimeInfos.new( request , railway_lines )
  end

end
