module TwitterHelper

  def twitter_official
    twitter_sub( "Twitter 東京メトロ【公式】" , "tokyometro_info" , 532627820543897600 )
  end

  def twitter_railway_line_info
    if @railway_lines.length == 1 or @railway_lines.map { | railway_line | railway_line.name_code } == [ "M" , "m" ]
      twitter_account_of_each_railway_line( @railway_lines.first )
    else
      @railway_lines.map { | railway_line |
        twitter_account_of_each_railway_line( railway_line )
      }.inject( :+ )
    end
  end

  private

  def twitter_account_of_each_railway_line( railway_line )
    title = "Twitter #{railway_line.name_ja}運行情報"
    account = "#{railway_line.name_code}_line_info"
    widget_id = twitter_data_widget_id_hash[ railway_line.name_code ]
    twitter_sub( title , account , widget_id )
  end

  def twitter_sub( title , account , widget_id )
    link_url = "https://twitter.com/#{account}"
    content_tag( :div , class: :twitter ) do
      concat link_to( title , link_url ,
        "data-widget-id" => widget_id ,
        class: "twitter-timeline" ,
        width: 240
      ) + twitter_script
    end
  end

  def twitter_script
    render( partial: "twitter_script" , type: :html )
  end

  def twitter_data_widget_id_hash
    {
      "G" => 532630018443059201 ,
      "M" => 532630724893868032 ,
      "H" => 532631112032321536 ,
      "T" => 532631565486923777 ,
      "C" => 532631847792959489 ,
      "Y" => 532632847350112256 ,
      "Z" => 532632130656825344 ,
      "N" => 532632503169724416 ,
      "F" => 532633227697991680
    }
  end

end