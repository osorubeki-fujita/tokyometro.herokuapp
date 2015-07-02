class BarrierFreeFacilityServiceDetailDecorator < Draper::Decorator

  delegate_all

  IN_DATA_FOR_TOOLTIP_JOINED_BY = " - "

  IN_DATA_CLASS_FOR_TOOLTIP_OPERATION_DAY_TITLE = "（operation_day）"
  IN_DATA_CLASS_FOR_TOOLTIP_ESCALATOR_DIRECTION_TITLE = "（escalator_direction）"
  IN_DATA_CLASS_FOR_TOOLTIP_SERVICE_TIME_TITLE = "（service_time）"

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%ul{ class: [ :service_detail , :clearfix ] }<
  - if this.has_any_info?
    - pattern = this.pattern.decorate
    - # 利用可能日
    = pattern.render_operation_day
    - # エスカレーターの方向
    - if this.has_escalator_direction_info?
      = this.escalator_direction.decorate.render
    - # 利用可能時間
    = pattern.render_service_time_info

    - # = this.id.to_s + " / " + pattern.id.to_s
    HAML
  end

  def in_data_class_for_tooltip
    ary = ::Array.new
    if pattern.operation_day.present?
      ary << "#{ IN_DATA_CLASS_FOR_TOOLTIP_OPERATION_DAY_TITLE }：#{ pattern.operation_day.name_ja } (#{ pattern.operation_day.name_en })"
    end
    if has_escalator_direction_info?
      ary << "#{ IN_DATA_CLASS_FOR_TOOLTIP_ESCALATOR_DIRECTION_TITLE }：#{ escalator_direction.to_s }"
    end
    if pattern.has_service_time_info?
      ary << "#{ IN_DATA_CLASS_FOR_TOOLTIP_SERVICE_TIME_TITLE }：#{ pattern.decorate.service_time_info_in_tooltip }"
    end
    ary.join( IN_DATA_FOR_TOOLTIP_JOINED_BY )
  end

end
