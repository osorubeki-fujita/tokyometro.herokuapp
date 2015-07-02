class StationFacilityPlatformInfoTransferInfoDecorator < Draper::Decorator
  delegate_all
  decorates_association :railway_line

  def necessary_time_to_s
    "（#{ necessary_time.to_s }分）"
  end

  def render
    ::TokyoMetro::App::Renderer::Concerns::Link::ToRailwayLinePage::ConnectingRailwayLine::FromPlatfromInfo.new( h.request , self ).render
  end

=begin
  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.railway_line.render_railway_line_code( must_display_line_color: true , small: true )
%div{ class: :text }
  %div{ class: :railway_line }<
    = this.railway_line.name_ja_in_station_facility_platform_info_transfer_info
  = this.render_railway_direction
  = this.render_necessary_time
    HAML
  end
=end

  def render_railway_direction
    if railway_direction.present?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%p{ class: :railway_direction }<
  = info.railway_direction.decorate.render_in_station_facility_platform_info_transfer_info
      HAML
    end
  end

  def render_necessary_time
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :time }<
  = info.necessary_time_to_s
    HAML
  end

end
