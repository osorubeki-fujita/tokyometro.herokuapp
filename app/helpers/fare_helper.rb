module FareHelper

  def fare_top_title
    render inline: <<-HAML , type: :haml
%div{ id: :fare_title }
  = fare_common_title
  = application_common_top_title
    HAML
  end

  # タイトルを記述するメソッド
  def fare_title_of_each_content
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :fare_title }
  = fare_common_title
  = station_name_main( station , station_code: true , all_station_codes: true )
    HAML
  end

  private

  def fare_common_title
    title_of_main_contents( fare_common_title_ja , fare_common_title_en )
  end

  def fare_common_title_ja
    "運賃のご案内"
  end

  def fare_common_title_en
    "Fares"
  end

end