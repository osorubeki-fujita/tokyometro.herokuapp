class Station::InfoDecorator::OnStationFacilityPage::RailwayLineInfos < ::TokyoMetro::Factory::Decorate::SubDecorator

  def initialize( decorator , request )
    super( decorator )
    @request = request
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.render_railway_line_infos_of_the_same_operator
= this.render_railway_line_infos_except_for_of_the_same_operator
    HAML
  end

  # 同一事業者の路線情報を表示する method
  def render_railway_line_infos_of_the_same_operator
    c_railway_line_infos = decorator.connecting_railway_line_infos_of_the_same_operator_connected_to_another_station

    h_locals = {
      this: self ,
      request: @request ,
      railway_line_infos_of_the_same_operator: railway_line_infos_of_the_same_operator ,
      c_railway_line_infos: c_railway_line_infos
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :tokyo_metro_railway_line_infos }
  = ::TokyoMetro::App::Renderer::StationFacility::Header::RailwayLines::TheSameOperator.new( request ).render
  %ul{ id: :railway_lines_in_this_station , class: [ :railway_lines , :clearfix ] }
    - railway_line_infos_of_the_same_operator.each do | railway_line |
      = ::TokyoMetro::App::Renderer::RailwayLine::LinkToPage.new( request , railway_line.decorate ).render
  - if c_railway_line_infos.present?
    %ul{ id: :railway_lines_in_another_station , class: [ :railway_lines , :clearfix ] }
      - c_railway_line_infos.each do | connecting_railway_line_info |
        = ::TokyoMetro::App::Renderer::ConnectingRailwayLine::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
  end

  # 他事業者の乗り換え情報を表示する method
  def render_railway_line_infos_except_for_of_the_same_operator
    # @param c_railway_line_infos [Array <Railway::Line::Info>] 他事業者の乗り入れ路線
    c_railway_line_infos = decorator.connecting_railway_line_infos_except_for_of_the_same_operator

    if c_railway_line_infos.present?
      h_locals = {
        c_railway_line_infos: c_railway_line_infos ,
        request: @request
      }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :other_railway_line_infos }
  = ::TokyoMetro::App::Renderer::StationFacility::Header::RailwayLines::OtherOperators.new( request ).render
  %ul{ id: :railway_lines_except_for_tokyo_metro , class: [ :railway_lines , :clearfix ] }
    - c_railway_line_infos.each do | connecting_railway_line_info |
      = ::TokyoMetro::App::Renderer::ConnectingRailwayLine::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
    end
  end

  private

  def railway_line_infos_of_the_same_operator
    object.railway_line_infos_of_tokyo_metro
  end

end
