class BarrierFreeFacilityServiceDetailPatternDecorator < Draper::Decorator

  delegate_all

  def service_time_info( skip_validity_check: false )
    unless skip_validity_check
      raise "Error" unless has_service_time_info?
    end
    time = String.new
    if self.service_start_before_first_train
      time << "始発"
    else
      time << ::ApplicationHelper.time_strf( service_start_time_hour , service_start_time_min )
      # time << "#{ service_start_time_hour }:#{ service_start_time_min }"
    end
    time << " ～ "
    if self.service_end_after_last_train
      time << "終電"
    else
      time << ::ApplicationHelper.time_strf( service_end_time_hour , service_end_time_min )
      # time << "#{ service_end_time_hour }:#{ service_end_time_min }"
    end
    time
  end

  def render_operation_day
    if operation_day_id.meaningful?
      operation_day.decorate.render_in_barrier_free_facility_service_detail_pattern
    end
  end

  def render_service_time_info
    if has_service_time_info?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :service_time }<
  = "利用可能時間：" + info.service_time_info( skip_validity_check: true )
      HAML
    end
  end

end