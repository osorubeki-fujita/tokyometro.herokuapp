class BarrierFreeFacilityServiceDetailDecorator < Draper::Decorator

  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%ul{ class: [ :service_detail , :clearfix ] }<
  - if this.has_any_info?
    - pattern = this.barrier_free_facility_service_detail_pattern.decorate
    - # 利用可能日
    = pattern.render_operation_day
    - # エスカレーターの方向
    - if this.has_escalator_direction_info?
      = this.escalator_direction.decorate.render
    - # 利用可能時間
    = pattern.render_service_time_info
    HAML
  end

end
