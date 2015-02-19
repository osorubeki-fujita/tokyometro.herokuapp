module WomenOnlyCarInfoHelper

  def render_women_only_car_infos
    infos = ::WomenOnlyCarInfo.where( railway_line_id: @railway_lines.pluck( :id ) ).includes( :operation_day , :from_station , :to_station )
    if infos.present?

      class << infos
        def have_only_one_railway_line?
          self.pluck( :railway_line_id ).length == 1
        end
        
        def only_one_railway_line
          if have_only_one_railway_line?
            ::RailwayLine.find( self.pluck( :railway_line_id ).first )
          else
            raise "Error"
          end
        end

        def infos_of_the_only_one_railway_line
          if have_only_one_railway_line?
            self
          else
            raise "Error"
          end
        end

        alias :of_the_only_one_railway_line :infos_of_the_only_one_railway_line
      end

      render inline: <<-HAML , type: :haml , locals: { infos: infos }
%div{ id: :women_only_car }
  = ::WomenOnlyCarInfoDecorator.render_sub_top_title
  - if infos.have_only_one_railway_line?
    - railway_line = infos.only_one_railway_line
    = railway_line.decorate.render_women_only_car_infos_in_a_railway_line( infos , in_group_of_multiple_railway_line: false )
  - else
    - infos.group_by( &:railway_line_id ).each do | railway_line_id , infos_of_a_railway_line |
      - railway_line = ::RailwayLine.find( railway_line_id )
      = railway_line.decorate.render_women_only_car_infos_in_a_railway_line( infos_of_a_railway_line , in_group_of_multiple_railway_line: true )
      HAML
    end
  end

  def render_women_only_car_infos_in_a_railway_line( infos )
    render inline: <<-HAML , type: :haml , locals: { infos: infos }
- infos.group_by( &:operation_day_id ).each do | operation_day_id , group_by_operation_day_id |
  %div{ class: :operation_day }<
    = ::OperationDay.find( operation_day_id ).decorate.render_in_women_only_car_info
    - group_by_operation_day_id.group_by( &:from_station_id ).each do | from_station_id , group_by_from_station_id |
      - group_by_from_station_id.group_by( &:to_station_id ).each do | to_station_id , group_by_from_and_to_station_id |
        %div{ class: :section }
          = group_by_from_and_to_station_id.first.decorate.render_title_of_section
          - group_by_from_and_to_station_id.group_by( &:available_time_to_s ).each do | available_time , group_by_available_time |
            %div{ class: :section_infos }
              %div{ class: [ :available_time , :text_en ] }<
                = available_time
              %div{ class: :infos }
                - group_by_available_time.each do | info |
                  = info.decorate.render_place
    HAML
  end

end