module FareHelper

  # タイトルを記述するメソッド
  def fare_title_of_each_content
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :fare_title }
  = ::FareDecorator.render_common_title
  = station.decorate.render_header( station_code: true , all_station_codes: true )
    HAML
  end

end