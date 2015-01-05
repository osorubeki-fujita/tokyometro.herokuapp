class BarrierFreeFacilityServiceDetailPattern < ActiveRecord::Base
  has_many :barrier_free_facility_service_details
  belongs_to :operation_day

  def has_any_info?
    self.operation_day_id.present? or self.has_service_time_info? or self.has_escalator_direction_info?
  end

  def has_service_time_info?
    ( self.service_start_before_first_train or ( self.service_start_time_hour.present? and self.service_start_time_min.present? ) ) and ( ( self.service_end_time_hour.present? and self.service_end_time_min.present? ) or self.service_end_after_last_train )
  end

  def has_escalator_direction_info?
    self.escalator_direction_up or self.escalator_direction_down
  end

  def service_time_info( skip_validity_check: false )
    unless skip_validity_check
      raise "Error" unless self.has_service_time_info?
    end
    time = String.new
    if self.service_start_before_first_train
      time << "始発"
    else
      time << ::ApplicationHelper.time_strf( self.service_start_time_hour , self.service_start_time_min )
      # time << "#{ self.service_start_time_hour }:#{ self.service_start_time_min }"
    end
    time << " ～ "
    if self.service_end_after_last_train
      time << "終電"
    else
      time << ::ApplicationHelper.time_strf( self.service_end_time_hour , self.service_end_time_min )
      # time << "#{ self.service_end_time_hour }:#{ self.service_end_time_min }"
    end
    time
  end

end