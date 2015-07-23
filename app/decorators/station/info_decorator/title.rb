class Station::InfoDecorator::Title < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render_in_passenger_survey_page
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :station )
  = decorator.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_fare_page
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ id: :fare_title }
  = ::Fare::InfoDecorator.render_common_title( request )
  = decorator.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_station_facility_page
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ id: :station_facility_title }
  = ::Station::Facility::InfoDecorator.render_common_title( request )
  = decorator.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_station_timetable_page
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ id: :station_facility_title }
  = ::Station::Timetable::InfoDecorator.render_common_title( request )
  = decorator.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_train_operation_page
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ id: :train_operation_info_title }
  = ::Train::Operation::InfoDecorator.render_common_title( request )
  = decorator.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def of_links_to_station_info_pages( with: nil )
    request = with
    raise unless request.present?
    ::TokyoMetro::App::Renderer::Concerns::Header::Content.new(
      request ,
      :title ,
      :station ,
      render_name_ja( with_subname: true , suffix: "駅に関するご案内" ) ,
      render_name_en( with_subname: true , prefix: "Other pages related to " , suffix: " Sta." ) ,
      icon_size: 3
    )
  end

end
