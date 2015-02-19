module RailwayLineNameHelper

  # タイトルのメイン部分（路線色・路線名）を記述するメソッド
  def railway_line_name_main( railway_lines )
    class << railway_lines
      include ForRails::RailwayLineArrayModule
    end

    render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
%div{ class: :main_text }
  - # タイトルの路線名を記述
  %div{ class: railway_lines.to_title_color_class }
    %h2{ class: :text_ja }<
      = railway_lines.to_railway_line_name_text_ja
    %h3{ class: :text_en }<
      = railway_lines.to_railway_line_name_text_en
    HAML
  end

end