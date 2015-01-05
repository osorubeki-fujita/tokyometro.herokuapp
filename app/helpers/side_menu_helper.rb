module SideMenuHelper

  def list_of_main_contents
    render inline: <<-HAML , type: :haml , locals: { method_name: __method__ }
%ul{ id: method_name }
  = link_to_a_content( "Top" , class_name: [ :link_to_top , :text_en ] )
  = link_to_a_content( "現在運行中の列車" , "train_location" )
  = link_to_a_content( "列車運行情報" , "train_information" )
  = link_to_a_content( "路線のご案内" , "railway_line" )
  = link_to_a_content( "駅のご案内" , "station_facility" )
  - # = link_to_a_content( "時刻表（路線別）" , "railway_timetable" )
  - # = link_to_a_content( "時刻表（駅別）" , "station_timetable" )
  = link_to_a_content( "時刻表" , "station_timetable" )
  = link_to_a_content( "運賃のご案内" , "fare" )
  = link_to_a_content( "各駅の乗降客数" , "passenger_survey" )
    HAML
  end

  def list_of_official_links
    render inline: <<-HAML , type: :haml , locals: { method_name: __method__ }
%ul{ id: method_name }
    = link_to_tokyo_metro_official
    = link_to_top_of_opendata_contest( class_name: [ :link, :small ] )
    = link_to_top_for_developer( class_name: [ :link, :small ] )
    HAML
  end

  def list_of_documents
    render inline: <<-HAML , type: :haml , locals: { method_name: __method__ }
%ul{ id: method_name }
    = link_to_document
    = link_to_how_to_use
    - # = link_to_disclaimer
    - # = link_to_remark
    - # = link_to_other_website( "開発続行用 別サイト" , "http://tokyosubway.heroku.com/" )
    HAML
  end

  private

  def link_to_a_content( title , controller = nil , class_name: :link_area )
    url = controller ? "/#{controller}/index" : "/"
    render inline: <<-HAML , type: :haml , locals: { title: title , url: url , class_name: class_name }
%li{ class: class_name }<
  = link_to_unless_current( "" , url , only_path_setting: false )
  %div<
    = title
    HAML
  end

end