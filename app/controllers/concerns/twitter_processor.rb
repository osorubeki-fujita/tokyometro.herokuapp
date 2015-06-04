module TwitterProcessor

  private

  def set_twitter_processor( setting = :railway_lines , railway_lines: @railway_lines )
    case setting
    when :railway_lines
      @twitter_processor = ::TokyoMetro::App::Renderer::Twitter.new( request , setting , railway_lines )
    when :tokyo_metro
      @twitter_processor = ::TokyoMetro::App::Renderer::Twitter.new( request , :tokyo_metro )
    end
  end

end
