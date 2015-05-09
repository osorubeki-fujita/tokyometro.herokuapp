class FareDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "運賃のご案内"
  end

  def self.common_title_en
    "Fares"
  end

  def self.render_header_of_fare_table
    h.render inline: <<-HAML , type: :haml
%tr{ class: :header }
  %td{ rowspan: 3 , class: [ :station_name_top , :header_bottom ] }<
    != "駅名"
    %span{ class: [ :small , :text_en ] }<
      = "Station"
  %td{ colspan: 4 , class: :normal_fare }<
    != "普通運賃"
    %span{ class: [ :small , :text_en ] }<
      = "Normal fare"
%tr{ class: [ :header , :fare_type ] }
  %td{ colspan: 2 , class: :ic_card }<
    != "ICカード利用"
    %span{ class: [ :small , :text_en ] }<
      = "IC card"
  %td{ colspan: 2 , class: :ticket }<
    != "切符"
    %span{ class: [ :small , :text_en ] }<
      = "Ticket"
%tr{ class: :header , class: :fares }
  - [ :ic_card , :ticket ].each do | group |
    %td{ class: [ group , :adult , :header_bottom ] }<
      != "大人"
      %span{ class: [ :small , :text_en ] }<
        = "Adult"
    %td{ class: [ group , :child , :header_bottom ] }<
      != "小児"
      %span{ class: [ :small , :text_en ] }<
        = "Child"
    HAML
  end

end