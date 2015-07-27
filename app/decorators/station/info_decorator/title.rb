class Station::InfoDecorator::Title < TokyoMetro::Factory::Decorate::SubDecorator

  # タイトルのメイン部分（駅名）を記述するメソッド
  def render_header( station_code: false , all_station_codes: false )
    if !( station_code ) and all_station_code
      raise "Error"
    end

    h_locals = h_decorator.merge( { station_code: station_code , all_station_codes: all_station_codes } )

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_text }
  %div{ class: [ :station_name , :tokyo_metro ] }
    %h2{ class: :text_ja }<
      = d.render_name_ja( with_subname: true )
    %h3<
      %span{ class: :text_hira }<>
        = d.render_name_hira( with_subname: true )
      %span{ class: :text_en }<
        = d.render_name_en( with_subname: true )
  - if station_code
    = d.code.render_image( all: all_station_codes )
    HAML
  end

  def render_in_passenger_survey_page
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :station )
  = this.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_fare_page
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ id: :fare_title }
  = ::Fare::InfoDecorator.render_common_title( request )
  = this.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_station_facility_page
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ id: :station_facility_title }
  = ::Station::Facility::InfoDecorator.render_common_title( request )
  = this.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_station_timetable_page
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ id: :station_facility_title }
  = ::Station::Timetable::InfoDecorator.render_common_title( request )
  = this.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_in_train_operation_page
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ id: :train_operation_info_title }
  = ::Train::Operation::InfoDecorator.render_common_title( request )
  = this.render_header( station_code: true , all_station_codes: true )
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
