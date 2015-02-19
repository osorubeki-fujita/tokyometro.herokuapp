class RailwayLineDecorator < Draper::Decorator
  delegate_all
  
  include CommonTitleRenderer
  extend SubTopTitleRenderer
  
  def self.common_title_ja
    "路線のご案内"
  end

  def self.common_title_en
    "Information of railway lines"
  end
  
  def self.render_title_of_train_info
    render_sub_top_title( text_ja: "運行情報" , text_en: "Train information" )
  end

  def name_ja_with_operator_name( process_special_railway_line: false )
    if process_special_railway_line
      case object.same_as
      when "odpt.Railway:Seibu.SeibuYurakucho"
        return "西武線"
      end
    end

    object.name_ja_with_operator_name
  end

  def name_en_with_operator_name( process_special_railway_line: false )
    if process_special_railway_line
      case object.same_as
      when "odpt.Railway:Seibu.SeibuYurakucho"
        return "Seibu Line"
      end
    end

    object.name_en_with_operator_name
  end

  def render_name( process_special_railway_line: false )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , process_special_railway_line: process_special_railway_line }
%div{ class: :text }<
  %div{ class: :text_ja }<>
    = info.name_ja_with_operator_name( process_special_railway_line: process_special_railway_line )
  %div{ class: :text_en }<>
    = info.name_en_with_operator_name( process_special_railway_line: process_special_railway_line )
    HAML
  end
  
  # @!group 女性専用車関連

  def render_women_only_car_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line , in_group_of_multiple_railway_line: false )
    h_locals = {
      info: self ,
      women_only_car_infos_of_a_railway_line: women_only_car_infos_of_a_railway_line ,
      in_group_of_multiple_railway_line: in_group_of_multiple_railway_line
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if in_group_of_multiple_railway_line
  %div{ class: [ info.css_class_name , :in_railway_line_group ] }
    = info.render_title_in_women_only_car_info
    = render_women_only_car_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line )
- else
  %div{ class: info.css_class_name }
    = render_women_only_car_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line )
    HAML
  end
  
  def render_title_in_women_only_car_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :title_of_a_railway_line }
  %h3{ class: :text_ja }<
    = info.name_ja
  %h4{ class: :text_en }<
    = info.name_en
    HAML
  end
  
  # @!endgroup
  
  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :railway_line }<
  %span{ class: :text_ja }<
    = info.name_ja
  %span{ class: :text_en }<
    = info.name_en
    HAML
  end

end