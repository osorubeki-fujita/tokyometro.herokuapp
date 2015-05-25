module ApplicationHelper

  def self.tokyo_metro
    ::Operator.find_by_same_as( "odpt.Operator:TokyoMetro" )
  end

  def self.common_title_ja
    "Rails on Ruby"
  end

  def self.common_title_en
    "Tokyo Metro Open Data Contest 2014"
  end

  def self.time_strf( h , m )
    m_2 = sprintf( "%2.2d" , m )
    "#{h}:#{m_2}"
  end

  def number_separated_by_comma( num )
    number_to_currency( num , unit: "" , format: "%n" , precision: 0 )
  end

  def time_info( title , time )
    render inline: <<-HAML , type: :haml , locals: { title: title , time: time }
%div{ class: :time_info }
  %div{ class: :title }<
    = title
  %div{ class: :time }<
    = time.to_strf_normal_ja
    HAML
  end
  
  def problems
    render inline: <<-HAML , type: :haml , locals: { request: request }
%div{ id: :problems }
  = problems_header
  %ul{ class: [ :info_text , :problems ] }
    - [ "リアルタイム情報の更新ボタンが動作しない" , "Twitterの縮小ボタンが動作しない" , "駅時刻表ページ（重大なバグが見つかったため公開を停止しています）" ].each do | info |
      %li{ class: :text_ja }<
        = info
    HAML
  end
  
  def problems_header
    ::TokyoMetro::App::Renderer::Concern::Header::Content.new( request , :problems , :info ,
      "既知の主な問題点" ,
      "Problems and bugs" ,
      icon_size: 2 ,
      size_setting_button_type: nil ,
      contoller_of_size_setting: nil ,
      add_update_button: false ,
      update_button_id: nil ,
      additional_content: nil
    ).render
  end

end