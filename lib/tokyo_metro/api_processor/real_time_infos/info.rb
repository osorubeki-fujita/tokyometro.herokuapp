class TokyoMetro::ApiProcessor::RealTimeInfos::RailwayLine::Info

  def initialize( railway_line , http_client )
    @railway_line = railway_line
    @http_client = http_client
  end

  attr_reader :railway_line
  attr_reader :http_client

  def has_train_information?
    @trian_information.present?
  end

  def dc_date_of_train_information
    @train_information.dc_date
  end
  alias :dc_date_time_of_train_information :dc_date_of_train_information

  def has_any_train_location?
    @train_locations.present?
  end

  def railway_line_same_as
    @railway_line.same_as
  end

end