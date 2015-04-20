class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Row::Section < TokyoMetro::App::Renderer::MetaClass

  def initialize(
    request , section_info , necessary_time ,
    left_columns , columns_next_to_railway_line , right_columns ,
    additional_info_left_between_stations , additional_info_next_to_railway_between_stations , additional_info_right_between_stations
  )
    super( request )
    @section_info = section_info
    @necessary_time = necessary_time

    @left_columns = left_columns
    @columns_next_to_railway_line = columns_next_to_railway_line
    @right_columns = right_columns

    @additional_info_left_between_stations = additional_info_left_between_stations
    @additional_info_next_to_railway_between_stations = additional_info_next_to_railway_between_stations
    @additional_info_right_between_stations = additional_info_right_between_stations
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: :between_stations }
  - if additional_info_left_between_stations.present? and additional_info_left_between_stations.has_procedure_of?( section_info )
    = additional_info_left_between_stations.render( section_info )
  - elsif left_columns > 1
    %td{ colspan: left_columns }<
      = " "
  - else
    %td<
      = " "

  - if additional_info_next_to_railway_between_stations.present? and additional_info_next_to_railway_between_stations.has_procedure_of?( section_info )
    = additional_info_next_to_railway_between_stations.render( section_info )
  - elsif columns_next_to_railway_line == 1
    %td<
      = " "
  - elsif columns_next_to_railway_line > 1
    %td{ colspan: columns_next_to_railway_line }<
      = " "

  %td{ class: :travel_time }<
    = "(" + necessary_time.to_s + ")"

  - if additional_info_right_between_stations.present? and additional_info_right_between_stations.has_procedure_of?( section_info )
    = additional_info_right_between_stations.render( section_info )
  - elsif right_columns > 1
    %td{ colspan: right_columns }<
      = " "
  - else
    %td<
      = " "
    HAML
  end

  private

  def h_locals
    super.merge({
      section_info: @section_info ,
      necessary_time: @necessary_time ,
      left_columns: @left_columns ,
      columns_next_to_railway_line: @columns_next_to_railway_line ,
      right_columns: @right_columns ,
      additional_info_left_between_stations: @additional_info_left_between_stations ,
      additional_info_next_to_railway_between_stations: @additional_info_next_to_railway_between_stations ,
      additional_info_right_between_stations: @additional_info_right_between_stations
    })
  end

end