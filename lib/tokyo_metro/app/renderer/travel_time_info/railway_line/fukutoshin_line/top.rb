class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine::Top < TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoAndFukutoshinLine::Top

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ :through_operation_info_row , position ] }
  %td{ class: :empty_column }<
    = " "
  %td{ class: [ :railway_line_column , :yurakucho_fukutoshin_seibu ] }<
    = " "
  %td{ class: :through_operation_infos , colspan: ( left_columns - 2 ) }
    = seibu_ikebukuro_line.render
  %td{ colspan: columns_next_to_railway_line }<
    = " "
  %td{ class: [ :railway_line_column , :yurakucho_fukutoshin_tobu ] }<
    = " "
  %td{ class: :through_operation_infos , colspan: right_columns }
    = tobu_tojo_line.render
%tr{ class: [ :through_operation_info_row , position ] , colspan: columns }
    HAML
  end

end