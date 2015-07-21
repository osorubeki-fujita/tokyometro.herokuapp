module TwitterProcessor

  private

  def set_twitter_processor( setting = :railway_line_infos , railway_line_infos: @railway_line_infos )
    case setting
    when :railway_line_infos
      @twitter_processor = ::TokyoMetro::App::Renderer::Twitter.new( request , setting , railway_line_infos )
    when :tokyo_metro
      @twitter_processor = ::TokyoMetro::App::Renderer::Twitter.new( request , :tokyo_metro )
    end
  end

end
