module StationCodeHelper

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
  - list_of_codes.each do | railway_line_code_letter |
    %div{ class: :station_code }<
      = railway_line_code_letter
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
      station = stations
      if all_station_codes
        list_of_station_codes_process_array( station.station_facility.stations ) 
      else
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

  def list_of_station_codes_process_array( ary )
    ary.sort_by( &:railway_line_id ).map( &:station_code ).uniq
  end

end