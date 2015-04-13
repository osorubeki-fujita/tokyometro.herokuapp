class TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , railway_line , terminal_station )
    super( request )
    @railway_line = railway_line
    @terminal_station = terminal_station
  end

  def render( suffix: nil )
    h = h_locals( suffix )
    v.render inline: <<-HAML , type: :haml , locals: h
%span{ class: :railway_line }<
  = railway_line.name_ja_with_operator_name_precise_and_without_parentheses
%span{ class: :terminal_station }<>
  = "「" + terminal_station.name_ja + "」"
- if suffix.present?
  %span<
    = suffix
    HAML
  end

  private

  def h_locals( suffix )
    super().merge({
      railway_line: @railway_line ,
      terminal_station: @terminal_station ,
      suffix: suffix
    })
  end

end