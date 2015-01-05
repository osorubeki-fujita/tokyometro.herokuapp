module StationNameHelper

  # タイトルのメイン部分（駅名）を記述するメソッド
  def station_name_main( station , station_code: false , all_station_codes: false )
    if !( station_code ) and all_station_code
      raise "Error"
    end

    render inline: <<-HAML , type: :haml , locals: { station: station , station_code: station_code , all_station_codes: all_station_codes }
%div{ class: :main_text }
  %div{ class: [ :station_name , :tokyo_metro ] }
    %h2{ class: :text_ja }<
      = station_name_ja_processing_subname( station.name_ja )
    %h3<
      %span{ class: :text_hira }<>
        = station_name_ja_processing_subname( station.name_hira )
      %span{ class: :text_en }<
        = station_name_en_processing_subname( station.name_en )
  - if station_code
    - # = display_station_codes( station , all_station_codes )
    = display_images_of_station_codes( station , all_station_codes )
    HAML
  end

  def station_text( stations , add_subname: true )
    render inline: <<-HAML , type: :haml , locals: { stations: [ stations ].flatten , add_subname: add_subname }
- name_ja = stations.first.name_ja
- name_hira = stations.first.name_hira
- name_en = stations.first.name_en
%div{ class: :text_ja }<>
  = station_name_ja_processing_subname( name_ja , add_subname: add_subname )
%div{ class: :text_en }<
  = station_name_en_processing_subname( name_en )
    HAML
  end

  def station_name_ja_processing_subname( name_ja , add_subname: true , suffix: "" )
    regexp = ::ApplicationHelper.regexp_for_parentheses_ja
    render inline: <<-HAML , type: :haml , locals: { name_ja: name_ja , add_subname: add_subname , regexp: regexp , suffix: suffix}
- if regexp =~ name_ja
  - name_ja_main = name_ja.gsub( regexp , "" ).process_specific_letter
  - name_ja_sub = $1
  - if add_subname
    = name_ja_main
    %span{ class: :small }<
      = name_ja_sub
    - if suffix.present?
      = suffix
  - else
    = name_ja_main + suffix
- else
  - name_ja = name_ja.process_specific_letter
  - if suffix.present?
    = name_ja + suffix
  - else
    = name_ja
    HAML
  end

  def station_name_en_processing_subname( name_en , suffix: "" )
    render inline: <<-HAML , type: :haml , locals: { name_en: name_en , suffix: suffix }
- regexp = ::ApplicationHelper.regexp_for_parentheses_en
- if regexp =~ name_en
  - name_en_main = name_en.gsub( regexp , "" )
  - name_en_sub = $1
  = name_en_main
  %span{ class: :small }<
    = name_en_sub
  - if suffix.present?
    = " " + suffix
- else
  - if suffix.present?
    - name_en_displayed = name_en + " " + suffix
  - else
    - name_en_displayed = name_en
  = name_en_displayed
    HAML
  end

  # Station のインスタンスをもとに駅番号の画像を表示するメソッド
  def display_images_of_station_codes( stations , all_station_codes )
    images_list = image_list_of_station_codes( stations , all_station_codes )
    display_images_of_station_codes_from_image_list( images_list )
  end

  # 駅番号の画像のファイル名のリストをもとに駅番号の画像を表示するメソッド
  def display_images_of_station_codes_from_image_list( images_list )
    render inline: <<-HAML , type: :haml , locals: { images_list: images_list }
%div{ class: :station_codes }
  - images_list.each do | image_filename |
    = image_tag( image_filename , class: :station_code )
    HAML
  end

  # Station のインスタンスをもとに駅番号の文字列を表示するメソッド
  def display_station_codes( station , all_station_codes )
    list_of_codes = list_of_station_codes( station , all_station_codes )
    render inline: <<-HAML , type: :haml , locals: { list_of_codes: list_of_codes }
%div{ class: :station_codes }<
  - list_of_codes.each do | railway_line_code |
    %div{ class: :station_code }<
      = railway_line_code
    HAML
  end

  private

  # Station のインスタンスから駅番号の画像のファイル名を取得するメソッド
  def image_list_of_station_codes( stations , all_station_codes )
    list_of_station_codes( stations , all_station_codes ).map { | station_code |
      dirname = "provided_by_tokyo_metro/station_number/"
      if /\Am(\d{2})\Z/ =~ station_code
        dirname += "mm#{$1}"
      else
        dirname += station_code.downcase
      end
      "#{dirname}.png"
    }
  end

  # Station のインスタンスから駅番号を取得するメソッド
  def list_of_station_codes( stations , all_station_codes )
    if stations.instance_of?( ::Station )
      if all_station_codes
        station = stations
        stations = list_of_station_codes_process_array( station.station_facility.stations ) 
      else
        station = stations
        [ station.station_code ]
      end
    else
      if all_station_codes
        list_of_station_codes_process_array( stations )
      else
        [ stations.first.station_code ]
      end
    end
  end

  def list_of_station_codes_process_array( arr )
    arr.sort_by { | station | station.railway_line_id }.map { | station | station.station_code }.uniq
  end

end