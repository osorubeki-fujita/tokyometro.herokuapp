class TokyoMetro::App::Renderer::WomenOnlyCarInfo::EachRailwayLine < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , railway_line , infos )
    super( request )
    @railway_line = railway_line
    @infos = infos
  end

  def render( display_railway_line: false )
    h.render inline: <<-HAML , type: :haml , locals: h_locals( display_railway_line )
- railway_line_decorated = railway_line.decorate
- if display_railway_line
  %div{ class: [ railway_line_decorated.css_class_name , :in_railway_line_group ] }
    = railway_line_decorated.render_title_in_women_only_car_info
    = this.render_each_women_only_car_info
- else
  %div{ class: railway_line_decorated.css_class_name }
    = this.render_each_women_only_car_info
    HAML
  end

  def render_each_women_only_car_info
    h.render inline: <<-HAML , type: :haml , locals: { infos: @infos }
- infos.group_by( &:operation_day_id ).each do | operation_day_id , group_by_operation_day_id |
  %div{ class: :operation_day }<
    = ::OperationDay.find( operation_day_id ).decorate.render_in_women_only_car_info
    - group_by_operation_day_id.group_by( &:from_station_info_id ).each do | from_station_info_id , group_by_from_station_info_id |
      - group_by_from_station_info_id.group_by( &:to_station_info_id ).each do | to_station_info_id , group_by_from_and_to_station_info_id |
        %div{ class: :section }
          = group_by_from_and_to_station_info_id.first.decorate.render_title_of_section
          - group_by_from_and_to_station_info_id.group_by( &:available_time_to_s ).each do | available_time , group_by_available_time |
            %div{ class: :section_infos }
              %div{ class: [ :available_time , :text_en ] }<
                = available_time
              %div{ class: :infos }
                - group_by_available_time.each do | info |
                  = info.decorate.render_place
    HAML
  end

  private

  def h_locals( display_railway_line )
    super().merge({
      this: self ,
      railway_line: @railway_line ,
      infos: @infos ,
      display_railway_line: display_railway_line
    })
  end

end