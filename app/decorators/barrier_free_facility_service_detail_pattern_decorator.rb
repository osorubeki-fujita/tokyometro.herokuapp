class BarrierFreeFacilityServiceDetailPatternDecorator < Draper::Decorator

  delegate_all

  JOIN_BY = "～"

  BEFORE_FIRST_TRAIN_TEXT = "始発"
  BEFORE_FIRST_TRAIN_ICON = :sun
  AFTER_LAST_TRAIN_TEXT = "終電"
  AFTER_LAST_TRAIN_ICON = :moon
  
  def service_time_info_in_tooltip
    service_time_info( skip_validity_check: true )
  end

  def render_operation_day
    if operation_day_id.meaningful?
      operation_day.decorate.render_in_barrier_free_facility_service_detail_pattern
    end
  end

  def render_service_time_info
    if has_service_time_info?
      h_locals = {
        this: self ,
        service_time_and_icon_info: service_time_and_icon_info ,
        join_by: JOIN_BY
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%li{ class: :service_time }<
  = ::TokyoMetro::App::Renderer::Icon.time( nil , 1 ).render
  %span{ class: :service_time_title }<
    = "利用可能時間："
  - if service_time_and_icon_info[ :time_from ][ :icon ].present?
    %span{ class: [ :before_first_train , :with_tooltip ] , 'data-en' => "When the station opens before the first train" }<
      = ::TokyoMetro::App::Renderer::Icon.send( service_time_and_icon_info[ :time_from ][ :icon ] , nil , 1 ).render
      != service_time_and_icon_info[ :time_from ][ :text ]
  - else
    %span{ class: :from }<
      = service_time_and_icon_info[ :time_from ][ :text ]
  %span{ class: :joint }<
    = join_by
  - if service_time_and_icon_info[ :time_until ][ :icon ].present?
    %span{ class: [ :after_last_train , :with_tooltip ] , 'data-en' => "When the station closes after the last train" }<
      = ::TokyoMetro::App::Renderer::Icon.send( service_time_and_icon_info[ :time_until ][ :icon ] , nil , 1 ).render
      != service_time_and_icon_info[ :time_until ][ :text ]
  - else
    %span{ class: :until }<
      = service_time_and_icon_info[ :time_until ][ :text ]
      HAML
    end
  end

  private

  def service_time_info( skip_validity_check: false )
    unless skip_validity_check
      raise "Error" unless has_service_time_info?
    end
    time = ::String.new

    if service_start_before_first_train?
      time << BEFORE_FIRST_TRAIN_TEXT
    else
      time << ::ApplicationHelper.time_strf( service_start_time_hour , service_start_time_min )
    end

    time << JOIN_BY

    if service_end_after_last_train?
      time << AFTER_LAST_TRAIN_TEXT
    else
      time << ::ApplicationHelper.time_strf( service_end_time_hour , service_end_time_min )
    end

    time
  end

  def service_time_and_icon_info
    time_from , time_until = service_time_info( skip_validity_check: true ).split( JOIN_BY )
    h = ::Hash.new
    h[ :time_from ] = ::Hash.new
    h[ :time_until ] = ::Hash.new

    if service_start_before_first_train?
      h[ :time_from ][ :text ] = BEFORE_FIRST_TRAIN_TEXT
      h[ :time_from ][ :icon ] = BEFORE_FIRST_TRAIN_ICON
    else
      h[ :time_from ][ :text ] = ::ApplicationHelper.time_strf( service_start_time_hour , service_start_time_min )
    end

    if service_end_after_last_train?
      h[ :time_until ][ :text ] = AFTER_LAST_TRAIN_TEXT
      h[ :time_until ][ :icon ] = AFTER_LAST_TRAIN_ICON
    else
      h[ :time_until ][ :text ] = ::ApplicationHelper.time_strf( service_end_time_hour , service_end_time_min )
    end

    h
  end

end
