class FareDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "運賃のご案内"
  end

  def self.common_title_en
    "Fares"
  end

  def self.render_top_title( text_ja: common_title_ja , text_en: common_title_en , id: :fare_title )
    super( text_ja: text_ja , text_en: text_en , id: id )
  end

  def self.render_header_of_fare_table
    render inline: <<-HAML , type: :haml
%tr{ class: :header }
  %td{ rowspan: 3 , class: [ :station_name_top , :header_bottom ] }<
    = "駅名"
  %td{ colspan: 4 , class: :normal_fare }<
    = "普通運賃"
%tr{ class: [ :header , :fare_type ] }
  %td{ colspan: 2 , class: :ic_card }<
    = "ICカード利用"
  %td{ colspan: 2 , class: :ticket }<
    = "切符"
%tr{ class: :header , class: :fares }
  - [ :ic_card , :ticket ].each do | group |
    %td{ class: [ group , :adult , :header_bottom ] }<
      = "大人"
    %td{ class: [ group , :child , :header_bottom ] }<
      = "小児"
    HAML
  end

end