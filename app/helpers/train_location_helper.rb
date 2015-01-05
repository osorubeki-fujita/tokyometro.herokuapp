module TrainLocationHelper

  def train_location_title_top
    render inline: <<-HAML , type: :haml
%div{ id: :train_location_title }
  = train_location_common_title
  = application_common_top_title
    HAML
  end

  # タイトルを記述するメソッド
  def train_location_title_of_each_content
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :train_location_title }
  = train_location_common_title
  = railway_line_name_main( railway_lines )
    HAML
  end

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

  def train_location_common_title
    title_of_main_contents( train_location_common_title_ja , train_location_common_title_en )
  end

  def train_location_common_title_ja
    "現在運行中の列車"
  end

  def train_location_common_title_en
    "Current train location"
  end

end