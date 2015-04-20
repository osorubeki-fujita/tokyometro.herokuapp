class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::TozaiLine::Bottom < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation

  def initialize( request , left_columns , columns_next_to_railway_line , right_columns )
    super( request , left_columns , columns_next_to_railway_line , right_columns )
    @position = :bottom
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ :through_operation_info_row , position ] , colspan: columns }
%tr{ class: [ :through_operation_info_row , position ] }
  %td{ class: :through_operation_infos }
    = jr_sobu_local_line.render
  %td{ class: [ :railway_line_column , :tozai_sobu ] }<
    = " "
  - ( left_columns - 2 ).times do
    %td{ class: :empty_column }<
      = " "
  %td{ colspan: columns_next_to_railway_line }<
    = " "
  %td{ class: [ :railway_line_column , :tozai_toyo ] }<
    = " "
  %td{ class: :through_operation_infos }
    = toyo_rapid_railway_line.render
    HAML
  end

  private

  def h_locals
    h_locals_base.merge({
      jr_sobu_local_line: ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::TozaiLine::Bottom::ToJrSobuLine.new( @request ) ,
      toyo_rapid_railway_line: ::TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::TozaiLine::Bottom::ToToyoRapidRailwayLine.new( @request )
    })
  end

end