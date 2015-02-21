module TrainLocationHelper

  def station_array
    content_tag( :table , id: :stations ) do
      concat body_of_station_array
    end
  end

  private

  def body_of_station_array
    content_tag( :tbody ) do
      @stations.each.with_index(1) do | station , i |
        concat info_of_station( station , i )
        unless i == @stations.length
          concat info_of_between_station( i )
        end
      end
    end
  end

  def info_of_station( station , i )
    content_tag( :tr ) do
      concat content_tag( :td , "↑" , class: :up )
      concat content_tag( :td , "" , class: :fukutoshin )
      concat content_tag( :td , "↓" , class: :down )
      concat content_tag( :td , "駅 #{i}" , class: :station_name )
    end
  end

end