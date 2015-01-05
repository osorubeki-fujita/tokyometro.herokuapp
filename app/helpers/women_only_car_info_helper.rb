module WomenOnlyCarInfoHelper

  def women_only_car_infos
    infos = women_only_car_info_array
    unless infos.empty?
      render inline: <<-HAML , type: :haml , locals: { infos: infos }
%div{ id: :women_only_car }
  = women_only_car_title
  - infos.each do | info |
    = women_only_car_info_each_info( info )
      HAML
    end
  end

  private

  def women_only_car_title
    title_of_each_content( "女性専用車のご案内" , "Women only car" )
  end

  # @return [Array]
  def women_only_car_info_array
    arr = Array.new
    @railway_lines.map do | railway_line |
      infos = railway_line.women_only_car_infos.includes( :operation_day , :from_station , :to_station )
      if infos.present?
        arr += infos
      end
    end
    arr
  end

  def women_only_car_info_each_info( info )
    render inline: <<-HAML , type: :haml , locals: { info: info }
- operation_day = info.operation_day.name_ja
- car_composition = "#{info.car_composition}両編成"
- car_number = "#{info.car_number}号車"

- from_sta = info.from_station.name_ja
- to_sta = info.to_station.name_ja
- section = from_sta + " → " + to_sta

- available_time_from = ::ApplicationHelper.time_strf( info.available_time_from_hour , info.available_time_from_min ) + "から"
- available_time_until = ::ApplicationHelper.time_strf( info.available_time_until_hour , info.available_time_until_min ) + "まで"

%div{ class: :info }
  = [ operation_day , car_composition , car_number , section , available_time_from , available_time_until ].join( "／" )
    HAML
  end

end