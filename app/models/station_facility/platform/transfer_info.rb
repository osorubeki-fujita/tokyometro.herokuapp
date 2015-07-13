class StationFacility::Platform::TransferInfo < ActiveRecord::Base
  belongs_to :platform_info , class: ::StationFacility::Platform::Info
  belongs_to :railway_line , class: ::RailwayLine
  belongs_to :railway_direction , class: ::RailwayDirection

  def to_array_of_displayed_infos
    [ railway_line_id , railway_direction_id , necessary_time ]
  end

end
