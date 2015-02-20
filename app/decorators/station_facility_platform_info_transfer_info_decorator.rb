class StationFacilityPlatformInfoTransferInfoDecorator < Draper::Decorator
  delegate_all
  decorates_association :railway_line
  
  def necessary_time_to_s
    "（#{ necessary_time.to_s }分）"
  end
  
  def render
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :transfer_info }
  %div{ class: info.railway_line.css_class_name }
    = info.railway_line.render_railway_line_code( must_display_line_color: true , small: true )
  %div{ class: :string }
    %div{ class: :railway_line }<
      = info.railway_line.railway_line_in_station_facility_platform_info_transfer_info
    - if info.railway_direction.present?
      %div{ class: :additional_info }
        = info.render_railway_direction
        = info.render_necessary_time
    - else
      = info.render_necessary_time
    HAML
  end
  
  def render_railway_direction
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :railway_direction }<
  = info.railway_direction.decorate.render_in_station_facility_platform_info_transfer_info
    HAML
  end

  def render_necessary_time
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :time }<
  = info.necessary_time_to_s
    HAML
  end

end