class BarrierFreeFacilityServiceDetailDecorator < Draper::Decorator

  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { service_detail: self }
%div{ class: :service_detail }<
  - if service_detail.has_any_info?
    - pattern = service_detail.barrier_free_facility_service_detail_pattern.decorate
    - # 利用可能日
    = pattern.render_operation_day
    - # エスカレーターの方向
    - if service_detail.has_escalator_direction_info?
      = service_detail.escalator_direction.decorate.render
    - # 利用可能時間
    = pattern.render_service_time_info
    HAML
  end

end