module RailwayTimetableHelper

  def railway_timetable_top_title
    render inline: <<-HAML , type: :haml
%div{ id: :railway_timetable_title }
  = railway_timetable_common_title
  = application_common_top_title
    HAML
  end

  def railway_timetable_title_of_each_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :railway_timetable_title }
  = railway_timetable_common_title
  = railway_line_name_main( railway_lines )
    HAML
  end

  private

  def railway_timetable_common_title
    title_of_main_contents( railway_timetable_common_title_ja , railway_timetable_common_title_en )
  end

  def railway_timetable_common_title_ja
    "各線の時刻表"
  end

  def railway_timetable_common_title_en
    "Timetable of railway line"
  end

end