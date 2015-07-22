class Railway::Line::InfoDecorator::Title < TokyoMetro::Factory::Decorate::AppSubDecorator

  def self.render_in_railway_line_page( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
%div{ id: :railway_line_title }
  = ::Railway::Line::InfoDecorator.render_common_title
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos )
    HAML
  end

  # タイトルを記述するメソッド（路線別）
  def self.render_in_passenger_survey_page( railway_line_infos , survey_year )
    h_locals = { infos: railway_line_infos , survey_year: survey_year }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :railway_line )
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos , survey_year: survey_year )
    HAML
  end

  def self.render_in_station_facility_page( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
%div{ id: :station_facility_title }
  = ::Station::Facility::InfoDecorator.render_common_title
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos )
    HAML
  end

  # 列車運行情報のタイトルを記述するメソッド
  def self.render_in_train_operation_page( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
%div{ id: :train_operation_info_title }
  = ::Train::Operation::InfoDecorator.render_common_title( request )
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos )
    HAML
  end

  # 列車位置情報のタイトルを記述するメソッド
  def self.render_in_train_location_page( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
%div{ id: :train_location_title }
  = ::Train::Location::InfoDecorator.render_common_title( request )
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos )
    HAML
  end

  def self.render_in_station_timetable_page( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
%div{ id: :station_timetable_title }
  = ::Station::Timetable::InfoDecorator.render_common_title( request )
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos )
    HAML
  end

  # @todo Revision
  def self.render_in_railway_timetable_page( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
%div{ id: :railway_timetable_title }
  = ::TokyoMetro::App::Renderer::Concerns::Header::Title::Base.new( request , ::RailwayTimetableHelper.common_title_ja , ::RailwayTimetableHelper.common_title_en ).render
  = ::Railway::Line::InfoDecorator::Title.render_name_main( infos )
    HAML
  end

  # タイトルのメイン部分（路線色・路線名）を記述するメソッド
  def self.render_name_main( railway_line_infos , survey_year: nil )
    railway_line_infos = [ railway_line_infos ].flatten
    class << railway_line_infos
      include ::TokyoMetro::TempLib::RailwayLineArrayModule
    end

    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos , survey_year: survey_year }
%div{ class: :main_text }
  - # タイトルの路線名を記述
  %div{ class: [ infos.to_title_color_class , :railway_line ] }
    %h2{ class: :text_ja }<
      = infos.to_railway_line_name_text_ja
    %h3{ class: :text_en }<
      = infos.to_railway_line_name_text_en
  - if survey_year.present?
    %div{ class: [ :survey_year , :text_en ] }<
      = survey_year
    HAML
  end

  [ :render_in_train_location_info , :render_in_women_only_car_info ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        render_simply
      end
    DEF
  end

  private

  def render_simply
    h.render inline: <<-HAML , type: :haml , locals: { object: object }
%div{ class: :title_of_a_railway_line }
  %h3{ class: :text_ja }<
    = object.name_ja
  %h4{ class: :text_en }<
    = object.name_en
    HAML
  end

end
