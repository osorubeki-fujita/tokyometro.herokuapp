module RailwayTimetableHelper

  def self.common_title_ja
    "各線の時刻表"
  end

  def self.common_title_en
    "Timetable of railway line"
  end

  def railway_timetable_title_of_each_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :railway_timetable_title }
  = render_common_title( common_title_ja: ::RailwayTimetableHelper.common_title_ja , common_title_en: ::DocumentHelper.common_title_en )
  = railway_line_name_main( railway_lines )
    HAML
  end

end