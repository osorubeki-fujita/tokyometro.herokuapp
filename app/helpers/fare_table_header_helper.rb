module FareTableHeaderHelper

  def fare_table_header
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
  = fare_table_header_adult_and_child( :ic_card )
  = fare_table_header_adult_and_child( :ticket )
    HAML
  end

  def fare_table_header_adult_and_child( additional_class )
    render inline: <<-HAML , type: :haml , locals: { additional_class: additional_class }
%td{ class: [ additional_class , :adult , :header_bottom ] }<
  = "大人"
%td{ class: [ additional_class , :child , :header_bottom ] }<
  = "小児"
    HAML
  end

end