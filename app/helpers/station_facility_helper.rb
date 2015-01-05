module StationFacilityHelper

  def station_facility_top_title
    render inline: <<-HAML , type: :haml
%div{ id: :station_facility_title }
  = station_facility_common_title
  = application_common_top_title
    HAML
  end

  def station_facility_title_of_each_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :station_facility_title }
  = station_facility_common_title
  = railway_line_name_main( railway_lines )
    HAML
  end

  def station_facility_title_of_each_station
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :station_facility_title }
  = station_facility_common_title
  = station_name_main( station , station_code: true , all_station_codes: true )
= passenger_survey_of_station
= tokyo_metro_railway_lines_in_a_station( station )
= connecting_railway_lines( station )
    HAML
  end

  private

  def station_facility_common_title
    title_of_main_contents( station_facility_common_title_ja , station_facility_common_title_en )
  end

  def station_facility_common_title_ja
    "駅のご案内"
  end

  def station_facility_common_title_en
    "Information of station and its facilities"
  end

  # 東京メトロの路線情報を表示する helper method
  # @param station [Station] 駅情報のインスタンス
  def tokyo_metro_railway_lines_in_a_station( station )
    render inline: <<-HAML , type: :haml , locals: { railway_lines: station.railway_lines_of_tokyo_metro }
- # @param connecting_railway_lines [Array <RailwayLine>] 東京メトロの路線
%div{ class: :tokyo_metro_railway_lines }
  %div{ class: :title }
    %div{ class: :text_ja }<
      = "東京メトロの路線"
    %div{ class: :text_en }<
      = "Railway lines of Tokyo Metro"
  %div{ class: :railway_lines }
    - railway_lines.each do | railway_line |
      = station_facility_railway_line_info( railway_line , true )
    HAML
  end

  # 他事業者の乗り換え情報を表示する helper method
  # @param station [Station] 駅情報のインスタンス
  def connecting_railway_lines( station )
    connecting_railway_lines = station.connecting_railway_lines_without_tokyo_metro
    if connecting_railway_lines.present?
      render inline: <<-HAML , type: :haml , locals: { railway_lines: connecting_railway_lines }
- # @param connecting_railway_lines [Array <RailwayLine>] 東京メトロ以外の乗り入れ路線
%div{ class: :connecting_railway_lines }
  %div{ class: :title }
    %div{ class: :text_ja }<
      = "乗り換え"
    %div{ class: :text_en }<
      = "Transfer"
  %div{ class: :railway_lines }
    - railway_lines.each do | railway_line |
      = station_facility_railway_line_info( railway_line , false )
      HAML
    end
  end

  def station_facility_railway_line_info( railway_line , tokyo_metro )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line  , tokyo_metro: tokyo_metro }
%div{ class: [ :railway_line , railway_line.css_class_name ] }<
  - if tokyo_metro
    - linked_page = "../railway_line/" + railway_line.name_en.gsub( " " , "_" ).underscore
    = link_to( "" , linked_page )
  = railway_line_code( railway_line , small: true )
  = railway_line_name_text( railway_line )
    HAML
  end

end