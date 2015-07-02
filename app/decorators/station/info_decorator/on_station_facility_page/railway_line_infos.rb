class Station::InfoDecorator::OnStationFacilityPage::RailwayLineInfos < ::TokyoMetro::Factory::Decorate::AppSubDecorator

  def initialize( decorator , request )
    super( decorator )
    @request = request
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.render_railway_lines_of_the_same_operator
= this.render_railway_lines_except_for_of_the_same_operator
    HAML
  end

  # 同一事業者の路線情報を表示する method
  def render_railway_lines_of_the_same_operator
    h_locals = {
      this: self ,
      request: @request ,
      railway_lines_of_the_same_operator: railway_lines_of_the_same_operator ,
      c_railway_lines: connecting_railway_lines_of_the_same_operator_connected_to_another_station
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :tokyo_metro_railway_lines }
  = ::TokyoMetro::App::Renderer::StationFacility::Header::RailwayLines::TheSameOperator.new( request ).render
  %ul{ id: :railway_lines_in_this_station , class: [ :railway_lines , :clearfix ] }
    - railway_lines_of_the_same_operator.each do | railway_line |
      = ::TokyoMetro::App::Renderer::RailwayLine::LinkToPage.new( request , railway_line.decorate ).render
  - if c_railway_lines.present?
    %ul{ id: :railway_lines_in_another_station , class: [ :railway_lines , :clearfix ] }
      - c_railway_lines.each do | connecting_railway_line_info |
        = ::TokyoMetro::App::Renderer::ConnectingRailwayLine::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
  end

  # 他事業者の乗り換え情報を表示する method
  def render_railway_lines_except_for_of_the_same_operator
    # @param c_railway_lines [Array <RailwayLine>] 他事業者の乗り入れ路線
    _connecting_railway_lines_except_for_of_the_same_operator = connecting_railway_lines_except_for_of_the_same_operator

    if _connecting_railway_lines_except_for_of_the_same_operator.present?
      h_locals = {
        c_railway_lines: _connecting_railway_lines_except_for_of_the_same_operator ,
        request: @request
      }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :other_railway_lines }
  = ::TokyoMetro::App::Renderer::StationFacility::Header::RailwayLines::OtherOperators.new( request ).render
  %ul{ id: :railway_lines_except_for_tokyo_metro , class: [ :railway_lines , :clearfix ] }
    - c_railway_lines.each do | connecting_railway_line_info |
      = ::TokyoMetro::App::Renderer::ConnectingRailwayLine::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
    end
  end

  private

  def railway_lines_of_the_same_operator
    object.railway_lines_of_tokyo_metro
  end

  def connecting_railway_lines_of_the_same_operator_connected_to_another_station
    decorator.send( __method__ )
  end

  def connecting_railway_lines_except_for_of_the_same_operator
    decorator.connecting_railway_lines_except_for_tokyo_metro
  end

end
