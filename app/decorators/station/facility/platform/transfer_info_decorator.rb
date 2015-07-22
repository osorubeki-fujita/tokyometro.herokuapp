class Station::Facility::Platform::TransferInfoDecorator < Draper::Decorator
  delegate_all

  def necessary_time_to_s
    "（#{ necessary_time.to_s }分）"
  end

  def render
    ::TokyoMetro::App::Renderer::Concerns::Link::ToRailwayLinePage::ConnectingRailwayLine::FromPlatfromInfo.new( h.request , self ).render
  end

end
