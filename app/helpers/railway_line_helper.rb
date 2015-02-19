module RailwayLineHelper

  def railway_line_title_of_each_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :railway_line_title }
  = ::RailwayLineDecorator.render_common_title
  = railway_line_name_main( railway_lines )
    HAML
  end

end