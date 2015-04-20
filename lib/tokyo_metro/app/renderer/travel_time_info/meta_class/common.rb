module TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Common

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: railway_line.decorate.travel_time_table_id }
  %table{ class: :travel_time_info }
    - if additional_info_top.present?
      = additional_info_top.call
      - # = ::TravelTimeInfoDecorator.render_empty_row
    - #
    - rows.each do | row |
      = row.render
    - #
    - if additional_info_bottom.present?
      - # = ::TravelTimeInfoDecorator.render_empty_row
      = additional_info_bottom.call
    HAML
  end

  private

  def common_procedures_when_initialize
    set_number_of_left_columns
    set_number_of_columns_next_to_railway_line
    set_number_of_right_columns

    set_station_infos
    set_section_infos
    set_travel_time_infos

    set_renderer_of_rows
  end

  def set_number_of_left_columns
    @left_columns = 1
  end

  def set_number_of_columns_next_to_railway_line
    @columns_next_to_railway_line = 0
  end

  def set_number_of_right_columns
    @right_columns = 1
  end

  def set_station_infos
    @station_infos = railway_line_base.station_infos.order( :index_in_railway_line )
  end

  def set_section_infos
    @section_infos = @station_infos.each_cons(2).to_a
  end

  def set_travel_time_infos
    @travel_time_infos = railway_line_base.travel_time_infos.includes( :from_station_info , :to_station_info )
  end

  def set_renderer_of_rows
    @rows = ::Array.new

    _renderers_of_station_infos = renderers_of_station_infos
    _renderers_of_section_infos = renderers_of_section_infos

    unless _renderers_of_station_infos.length == _renderers_of_section_infos.length + 1
      raise "Error"
    end

    _renderers_of_station_infos.each_with_index do | row_info , i |
      @rows << row_info
      unless i == _renderers_of_station_infos.length - 1
        @rows << _renderers_of_section_infos[i]
      end
    end
  end

  def renderers_of_station_infos
    @station_infos.map { | info |
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Row::Station.new(
        @request , info ,
        @left_columns , @columns_next_to_railway_line , @right_columns ,
        additional_info_left_on_station , additional_info_next_to_railway_on_station , additional_info_right_on_station
      )
    }
  end

  def renderers_of_section_infos
    @section_infos.map { | info |
      necessary_time = @travel_time_infos.between( *info ).pluck( :necessary_time ).max
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Row::Section.new(
        @request , info , necessary_time ,
        @left_columns , @columns_next_to_railway_line , @right_columns ,
        additional_info_left_between_stations , additional_info_next_to_railway_between_stations , additional_info_right_between_stations
      )
    }
  end

  def h_locals
    super.merge({
      railway_line: railway_line_base ,
      rows: @rows ,
      additional_info_top: additional_info_top ,
      additional_info_bottom: additional_info_bottom
    })
  end

  def additional_info_top
    nil
  end

  def additional_info_bottom
    nil
  end

  def additional_info_left_on_station
    nil
  end

  def additional_info_left_between_stations
    nil
  end

  def additional_info_next_to_railway_on_station
    nil
  end

  def additional_info_next_to_railway_between_stations
    nil
  end

  def additional_info_right_on_station
    nil
  end

  def additional_info_right_between_stations
    nil
  end

end