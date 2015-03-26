class TravelTimeInfoDecorator < Draper::Decorator
  delegate_all

  extend SubTopTitleRenderer

  def self.sub_top_title_ja
    "停車駅と所要時間のご案内"
  end

  def self.sub_top_title_en
    "Stops and travel time"
  end

  def self.render_empty_row
    h.render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan: 3 }<
    = " "
    HAML
  end

  def self.render_info_between_stations( travel_time_infos , section )
    h_locals = {
      travel_time_infos: travel_time_infos ,
      section: section
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- necessary_time = travel_time_infos.between( *section ).pluck( :necessary_time ).max
= "(" + necessary_time.to_s + ")"
    HAML
  end

  def self.render_travel_time_info_through_operation_info( train_type: nil , from: nil , direction: nil , via: nil , railway_line_and_terminal_station_info: nil , info: nil )
    raise "Error" if railway_line_and_terminal_station_info.nil?

    h_locals = {
      train_type: train_type ,
      from: from ,
      direction: direction ,
      via: via ,
      railway_line_and_terminal_station_info: railway_line_and_terminal_station_info ,
      info: info
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if train_type.present?
  = train_type.decorate.render_name_box_in_travel_time_info
%div{ class: :through_operation_info }
  - if from.present?
    %p{ class: :from }<
      = "〈" + from.name_ja + "から〉"
  - if direction.present? or via.present?
    %div{ class: :railway_line }<
      - if direction.present?
        %span{ class: :direction }<
          = [ direction ].flatten.map( &:name_ja ).join( "、" ) + "方面"
      - if via.present?
        %span{ class: :via }<
          :ruby
            ary = [ via ].flatten.map( &:name_ja_with_operator_name_precise_and_without_parentheses )
          = ary.join( "、" ) + "経由"
  %div{ class: :main }<
    - set_of_railway_line_and_terminal_station_info = [ railway_line_and_terminal_station_info ].flatten
    - set_of_railway_line_and_terminal_station_info.each.with_index(1) do | info , i |
      %span{ class: :railway_line }<
        = info[ :railway_line ].name_ja_with_operator_name_precise_and_without_parentheses
      %span{ class: :terminal_station_info }<
        = "「" + info[ :terminal_station_info ].name_ja + "」"
      - if set_of_railway_line_and_terminal_station_info.length > 1 and set_of_railway_line_and_terminal_station_info.length > i
        = "・"
    = "まで直通運転"
  - if info.present?
    %div{ class: :info }<
      :ruby
        str = "（#{info}）"
      = str
    HAML
  end

  def self.proc_for_rendering_through_operation_info_of_hibiya_line_and_tobu_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :bottom ] }<
  %td{ class: [ :railway_line_column , :hibiya_tobu ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Railway:Tobu.SkyTree.Koshigaya" ) ,
          ::Station::Info.find_by_same_as( "odpt.Railway:Tobu.SkyTree.Kasukabe" ) ,
          ::Station::Info.find_by_same_as( "odpt.Railway:Tobu.SkyTree.TobuDobutsuKoen" )
        ] ,
        via: ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.SkyTree" ) ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.Nikko" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Tobu.Nikko.MinamiKurihashi" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_tozai_line_and_jr_chuo_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :top ] }<
  %td{ class: [ :railway_line_column , :tozai_chuo ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        via:  ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.ChuoSobu" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:JR-East.ChuoTozai.Mitaka" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_tozai_line_jr_sobu_line_and_toyo_rapid_railway_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :bottom ] }<
  %td{ class: [ :railway_line_column , :tozai_toyo ] }<
  %td{ class: :through_operation_infos }<
    :ruby
      h = {
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:ToyoRapidRailway.ToyoRapidRailway" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:ToyoRapidRailway.ToyoRapidRailway.ToyoKatsutadai" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
  %td{ class: [ :railway_line_column , :tozai_sobu ] }<
  %td{ class: :through_operation_infos }<
    :ruby
      h = {
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.ChuoSobu" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:JR-East.SobuTozai.Tsudanuma" )
        } ,
        note: "直通運転は朝夕のみ"
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_chiyoda_line_and_odakyu_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :top ] }<
  %td{ class: :chiyoda_odakyu }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    %div{ class: :through_operation_info_box }
      :ruby
        h = {
          train_type: ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Chiyoda.TamaExpress.ForOdakyu" ) ,
          direction: [
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.SeijoGakuenMae" ) ,
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.Noborito" ) ,
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.ShinYurigaoka" )
          ] ,
          railway_line_and_terminal_station_info: {
            railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Odakyu.Tama" ) ,
            terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Tama.Karakida" )
          }
        }
      = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      
    %div{ class: :through_operation_info_box }
      :ruby
        h = {
          train_type: ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Chiyoda.SemiExpress.ForOdakyu" ) ,
          direction: [
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.SeijoGakuenMae" ) ,
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.Noborito" ) ,
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.ShinYurigaoka" ) ,
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.Machida" ) ,
            ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.Ebina" )
          ] ,
          railway_line_and_terminal_station_info: {
            railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Odakyu.Odawara" ) ,
            terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.HonAtsugi" )
          }
        }
      = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      
    %div{ class: :through_operation_info_box }
      :ruby
        h = {
          train_type: ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal" ) ,
          railway_line_and_terminal_station_info: [{
            railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Odakyu.Tama" ) ,
            terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Tama.Karakida" )
          },{
            railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Odakyu.Odawara" ) ,
            terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Odakyu.Odawara.HonAtsugi" )
          },{
            railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:HakoneTozan.Rail.OdawaraSide" ) ,
            terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:HakoneTozan.Rail.HakoneYumoto" )
          }]
        }
      = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_chiyoda_line_and_jr_joban_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :bottom ] }<
  %td{ class: :chiyoda_joban }<
    = ""
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        from: ::Station::Info.find_by_same_as( "odpt.Station:TokyoMetro.Chiyoda.Ayase" ) ,
        direction: [ 
          ::Station::Info.find_by_same_as( "odpt.Station:JR-East.Joban.Matsudo" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:JR-East.Joban.Kashiwa" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:JR-East.Joban.Abiko" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:JR-East.Joban.Toride" )
        ] ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Joban" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:JR-East.Joban.Toride" )
        } ,
        info: "取手までの直通運転は朝夕のみ、日中は我孫子まで"
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_hanzomon_line_and_tokyu_den_en_toshi_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :top ] }<
  %td{ class: [ :railway_line_column , :hanzomon_tokyu ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.DenEnToshi.FutakoTamagawa" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.DenEnToshi.Nagatsuta" )
        ] ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Tokyu.DenEnToshi" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.DenEnToshi.ChuoRinkan" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_hanzomon_line_and_tobu_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :bottom ] }<
  %td{ class: [ :railway_line_column , :hanzomon_tobu ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Station:Tobu.SkyTree.KitaSenju" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tobu.SkyTree.Koshigaya" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tobu.SkyTree.Kasukabe" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tobu.SkyTree.TobuDobutsuKoen" )
        ] ,
        via: ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.SkyTree" ) ,
        railway_line_and_terminal_station_info: [{
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.Isesaki" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Tobu.Isesaki.Kuki" )
        },{
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.Nikko" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Tobu.Nikko.MinamiKurihashi" )
        }]
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_namboku_line_and_tokyu_meguro_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :top ] }<
  %td{ class: [ :railway_line_column , :namboku_tokyu ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Meguro.Oookayama" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Meguro.MusashiKosugi" )
        ] ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Tokyu.Meguro" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Meguro.Hiyoshi" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_namboku_line_and_saitama_railway_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :bottom ] }<
  %td{ class: [ :railway_line_column , :namboku_saitama ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        direction: ::Station::Info.find_by_same_as( "odpt.Station:SaitamaRailway.SaitamaRailway.HigashiKawaguchi" ) ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:SaitamaRailway.SaitamaRailway" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:SaitamaRailway.SaitamaRailway.UrawaMisono" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
    }
  end

  def self.proc_for_rendering_through_operation_info_of_yurakucho_line_tobu_tojo_line_and_seibu_ikebukuro_line
    proc_for_rendering_through_operation_info_of_yurakucho_fukutoshin_line_tobu_tojo_line_and_seibu_ikebukuro_line( ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Yurakucho" ) )
  end

  def self.proc_for_rendering_through_operation_info_of_fukutoshin_line_tobu_tojo_line_and_seibu_ikebukuro_line
    proc_for_rendering_through_operation_info_of_yurakucho_fukutoshin_line_tobu_tojo_line_and_seibu_ikebukuro_line( ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Fukutoshin" ) )
  end

  def self.proc_for_rendering_through_operation_info_of_fukutoshin_line_and_tokyu_toyoko_mm_line
    Proc.new {
      h.render inline: <<-HAML , type: :haml
%tr{ class: [ :through_operation_info_row , :bottom ] }<
  %td{ class: [ :railway_line_column , :fukutoshin_tokyu_mm ] }<
  %td{ colspan: 3 , class: :through_operation_infos }<
    :ruby
      h = {
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Toyoko.NakaMeguro" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Toyoko.MusashiKosugi" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Toyoko.Kikuna" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Toyoko.Yokohama" )
        ] ,
        via: ::RailwayLine.find_by_same_as( "odpt.Railway:Tokyu.Toyoko" ) ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:YokohamaMinatomiraiRailway.Minatomirai" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:YokohamaMinatomiraiRailway.Minatomirai.MotomachiChukagai" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
    HAML
    }
  end

  def render_simple_info
    h.render inline: <<-HAML , type: :haml , locals: { travel_time_info: self }
%div{ class: :info }
  = travel_time_info.to_s
    HAML
  end

  class << self

    private

    def proc_for_rendering_through_operation_info_of_yurakucho_fukutoshin_line_tobu_tojo_line_and_seibu_ikebukuro_line( railway_line )
      Proc.new {
        h.render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line }
- wakoshi = ::Station::Info.find_by( name_in_system: "Wakoshi" , railway_line_id: railway_line.id )
- kotake_mukaihara = ::Station::Info.find_by( name_in_system: "KotakeMukaihara" , railway_line_id: railway_line.id)
%tr{ class: [ :through_operation_info_row , :top ] }<
  %td{ class: [ railway_line.css_class_name + "_tobu" , :railway_line_column ] }<
  %td{ class: :through_operation_infos }<
    :ruby
      h = {
        from: wakoshi ,
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Station:Tobu.Tojo.Kawagoe" )
        ] ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.Tojo" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Tobu.Tojo.ShinrinKoen" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
  %td{ class: [ railway_line.css_class_name + "_seibu" , :railway_line_column ] }<
  %td{ class: :through_operation_infos }<
    :ruby
      h = {
        from: kotake_mukaihara ,
        direction: [
          ::Station::Info.find_by_same_as( "odpt.Station:Seibu.Yurakucho.Nerima" ) ,
          ::Station::Info.find_by_same_as( "odpt.Station:Seibu.Ikebukuro.Tokorozawa" )
        ] ,
        railway_line_and_terminal_station_info: {
          railway_line: ::RailwayLine.find_by_same_as( "odpt.Railway:Seibu.Ikebukuro" ) ,
          terminal_station_info: ::Station::Info.find_by_same_as( "odpt.Station:Seibu.Ikebukuro.Hanno" )
        }
      }
    = ::TravelTimeInfoDecorator.render_travel_time_info_through_operation_info(h)
      HAML
      }
    end
  
  end

end