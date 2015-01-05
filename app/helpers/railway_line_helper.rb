module RailwayLineHelper

  def railway_line_top_title
    render inline: <<-HAML , type: :haml
%div{ id: :railway_line_title }
  = railway_line_common_title
  = application_common_top_title
    HAML
  end

  def railway_line_title_of_each_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :railway_line_title }
  = railway_line_common_title
  = railway_line_name_main( railway_lines )
    HAML
  end

  private

  def railway_line_common_title
    title_of_main_contents( railway_line_common_title_ja , railway_line_common_title_en )
  end

  def railway_line_common_title_ja
    "路線のご案内"
  end

  def railway_line_common_title_en
    "Information of railway lines"
  end

end