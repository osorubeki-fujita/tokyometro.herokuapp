module StationInfoHelper

  def station_info_links
    contents = [ [ "駅からの列車運行状況" , "train_information" ] , [ "駅の時刻表" , "station_timetable" ] , [ "駅施設のご案内" , "station_facility" ] ]
    h_locals = {
      station: @station ,
      contents: contents
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :station_info_links }
  %div{ class: :station_name }<
    %h2{ class: :text_ja }<
      = station_name_ja_processing_subname( station.name_ja , add_subname: true , suffix: "駅に関するご案内" )
    %h3{ class: :text_en }<
      = "Other pages related to " + station.name_en + " Station"
  %div{ class: :links }
    - contents.each do | title , body |
      %div{ class: :link }<
        = link_to_unless_current( title , "../" + body + "/" + station.name_in_system.underscore )
    HAML
  end

end