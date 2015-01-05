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

  def railway_line_name_text( railway_line , process_special_railway_line: false )
    if process_special_railway_line and railway_line.same_as == "odpt.Railway:Seibu.SeibuYurakucho"
      ja = "西武線"
      en = "Seibu Line"
    else
      ja = railway_line.name_ja_with_operator_name
      en = railway_line.name_en_with_operator_name
    end
    render inline: <<-HAML , type: :haml , locals: { ja: ja , en: en }
%div{ class: :text }<
  %div{ class: :text_ja }<>
    = ja
  %div{ class: :text_en }<>
    = en
    HAML
  end

end