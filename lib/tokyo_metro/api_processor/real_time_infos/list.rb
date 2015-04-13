class TokyoMetro::ApiProcessor::RealTimeInfos::RailwayLine::List < ::Array

  def has_any_train_information?
    self.any?( &:has_train_information? )
  end

  def dc_date_times_of_train_information
    self.map( &:dc_date_time_of_train_information ).sort
  end

  def validity_times_of_train_information
    @infos_of_each_railway_line.map( &:train_information ).map( &:validity )
  end

  def has_any_train_location?
    self.any?( &:has_any_train_location? )
  end

  def railway_lines
    self.map( &:railway_line )
  end

  def railway_lines_same_as
    self.map( &:railway_line_same_as )
  end

  def dc_date_times_of_train_location_info
    @infos_of_each_railway_line.map( &:train_locations ).flatten.map( &:dc_date )
  end

  def validity_times_of_train_location_info
    @infos_of_each_railway_line.map( &:train_locations ).flatten.map( &:validity )
  end

  def frequency_of_train_location_info
    @infos_of_each_railway_line.map( &:train_locations ).flatten.map( &:frequency )
  end

end