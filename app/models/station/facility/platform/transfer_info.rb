class Station::Facility::Platform::TransferInfo < ActiveRecord::Base
  belongs_to :platform_info , class: ::Station::Facility::Platform::Info
  belongs_to :railway_line_info , class: ::Railway::Line::Info
  belongs_to :railway_direction , class: ::Railway::Direction

  def to_array_of_displayed_infos
    [ railway_line_info_id , railway_direction_id , necessary_time ]
  end

end
