class Station::InfoDecorator::OnStationFacilityPage < TokyoMetro::Factory::Decorate::AppSubDecorator

  def railway_line_infos( request )
    ::Station::InfoDecorator::OnStationFacilityPage::RailwayLineInfos.new( @decorator , request )
  end

  def render_link_to_page_of_connecting_other_stations( request , controller )
    c_railway_lines = decorator.connecting_railway_line_infos_of_the_same_operator_connected_to_another_station

    if c_railway_lines.present?
      station_facility_info_ids = c_railway_lines.map( &:connecting_station_info ).uniq.map( &:station_facility_info_id ).uniq
      station_infos = station_facility_info_ids.map { | station_facility_info_id |
        ::Station::Facility::Info.find( station_facility_info_id ).station_infos.first
      }

      h_locals = {
        request: request ,
        station_infos: station_infos ,
        controller: controller
      }

      h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ id: :list_of_links_to_station_facility_page_of_connecting_other_stations , class: :clearfix }
  - station_infos.each do | station_info |
    %li{ class: [ :normal , :clearfix ] }
      = link_to( "" , url_for( controller: controller , action: :action_for_station_page , station: station_info.station_page_name ) , class: :link )
      %div{ class: [ controller , :link_to_content , :clearfix ] }
        - unless controller.to_s == "station_facility"
          %div{ class: :icon }
            = ::TokyoMetro::App::Renderer::Icon.send( controller , request , 1 ).render
        - else
          %div{ class: :icon }
            %div{ class: :icon_img }<
        %div{ class: :text }
          = station_info.decorate.render_name_ja_and_en( suffix_ja: "駅" , prefix_en: "Information of " , suffix_en: " Sta." )
      HAML
    end
  end

end
