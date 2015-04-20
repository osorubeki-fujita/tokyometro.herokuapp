class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Row::Station < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , station_info ,
    left_columns , columns_next_to_railway_line , right_columns ,
    additional_info_left_on_station , additional_info_next_to_railway_on_station , additional_info_right_on_station
  )
    super( request )
    @station_info = station_info

    @left_columns = left_columns
    @columns_next_to_railway_line = columns_next_to_railway_line
    @right_columns = right_columns

    @additional_info_left_on_station = additional_info_left_on_station
    @additional_info_next_to_railway_on_station = additional_info_next_to_railway_on_station
    @additional_info_right_on_station = additional_info_right_on_station
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- station_info_decorated = station_info.decorate

%tr{ class: :station_info_row }

  - if additional_info_left_on_station.present? and additional_info_left_on_station.has_procedure_of?( station_info )
    = additional_info_left_on_station.render( station_info )
  - elsif left_columns > 1
    %td{ class: :transfer , colspan: left_columns }
      = station_info_decorated.render_connecting_railway_lines_in_travel_time_infos
  - else
    %td{ class: :transfer }
      = station_info_decorated.render_connecting_railway_lines_in_travel_time_infos

  - if columns_next_to_railway_line > 0 and additional_info_next_to_railway_on_station.present? and additional_info_next_to_railway_on_station.has_procedure_of?( station_info )
    = additional_info_next_to_railway_on_station.render( station_info )
  - elsif columns_next_to_railway_line == 1
    %td<
      = " "
  - elsif columns_next_to_railway_line > 1
    %td{ colspan: columns_next_to_railway_line }<
      = " "

  %td{ class: :railway_line_column }<
    %div{ class: :travel_time_info_square }<
      = " "

  - if additional_info_right_on_station.present? and additional_info_right_on_station.has_procedure_of?( station_info )
    = additional_info_right_on_station.render( station_info )
  - elsif right_columns > 1
    %td{ class: :station_info , colspan: right_columns }
      = station_info_decorated.render_name_in_travel_time_infos
  - else
    %td{ class: :station_info }
      = station_info_decorated.render_name_in_travel_time_infos
    HAML
  end

  private

  def h_locals
    super.merge({
      station_info: @station_info ,
      left_columns: @left_columns ,
      columns_next_to_railway_line: @columns_next_to_railway_line ,
      right_columns: @right_columns ,
      additional_info_left_on_station: @additional_info_left_on_station ,
      additional_info_next_to_railway_on_station: @additional_info_next_to_railway_on_station ,
      additional_info_right_on_station: @additional_info_right_on_station
    })
  end

end