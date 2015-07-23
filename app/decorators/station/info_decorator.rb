class Station::InfoDecorator < Draper::Decorator

  delegate_all

  decorates_association :station_facility

  [
    :in_google_maps , :in_train_location , :in_fare_table , :in_station_timetable ,
    :in_travel_time_info , :in_transfer_info , :in_matrix ,
    :on_station_facility_page , :code , :title , :as_direction_info
  ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        ::Station::InfoDecorator::#{ method_name.camelize }.new( self )
      end
    DEF
  end

  def name_ja_with_station_code
    name_with_station_code( name_ja_actual )
  end

  def name_en_with_station_code
    name_with_station_code( name_en )
  end

  def name_ja_and_en_with_station_code
     "#{ name_ja_with_station_code } (#{ name_en })"
  end

  def connecting_railway_line_infos_of_the_same_operator_connected_to_another_station
    connecting_railway_line_infos.includes( :railway_line_info ).order( :railway_line_info_id ).of_the_same_operator.connected_to_another_station
  end

  def connecting_railway_line_infos_except_for_of_the_same_operator
    connecting_railway_line_infos.includes( :railway_line_info ).order( :railway_line_info_id ).except_for_of_the_same_operator
  end

  def render_name_ja( with_subname: true , prefix: nil , suffix: nil )
    render_name_ja_or_hira( name_ja_actual , with_subname , prefix , suffix )
  end

  def render_name_hira( with_subname: true , prefix: nil , suffix: nil )
    render_name_ja_or_hira( name_hira , with_subname , prefix , suffix )
  end

  def render_name_en( with_subname: true , prefix: nil , suffix: nil )
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_quotation
    if regexp =~ name_en
      name_main = name_en.gsub( regexp , "" )
      name_sub = $1
    else
      name_main = name_en
      name_sub = nil
    end

    if prefix.present?
      name_main = prefix + name_main
    end

    h_locals = {
      name_main: name_main ,
      name_sub: name_sub ,
      with_subname: with_subname ,
      suffix: suffix
    }

    if name_sub.present? and with_subname
      name_main_txt = name_main + "&nbsp;"
      h.render inline: <<-HAML , type: :haml , locals: h_locals.merge({ name_main_txt: name_main_txt })
= raw( name_main_txt )
%span{ class: :small }<>
  = name_sub
- if suffix.present?
  = suffix
      HAML

    elsif suffix.present?
      h.render inline: <<-HAML , type: :haml , locals: h_locals
= ( name_main + " " + suffix )
      HAML
    else
      h.render inline: <<-HAML , type: :haml , locals: h_locals
= name_main
      HAML
    end
  end

  def render_name_ja_and_en( with_subname: true , suffix_ja: nil , prefix_en: nil , suffix_en: nil )
    h.render inline: <<-HAML , type: :haml , locals: { this: self , with_subname: with_subname , suffix_ja: suffix_ja , prefix_en: prefix_en , suffix_en: suffix_en }
%p{ class: :text_ja }<>
  = this.render_name_ja( with_subname: with_subname , suffix: suffix_ja )
%p{ class: :text_en }<
  = this.render_name_en( with_subname: with_subname , prefix: prefix_en , suffix: suffix_en )
    HAML
  end

  # タイトルのメイン部分（駅名）を記述するメソッド
  def render_header( station_code: false , all_station_codes: false )
    if !( station_code ) and all_station_code
      raise "Error"
    end

    h_locals = { this: self , station_code: station_code , all_station_codes: all_station_codes }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_text }
  %div{ class: [ :station_name , :tokyo_metro ] }
    %h2{ class: :text_ja }<
      = this.render_name_ja( with_subname: true )
    %h3<
      %span{ class: :text_hira }<>
        = this.render_name_hira( with_subname: true )
      %span{ class: :text_en }<
        = this.render_name_en( with_subname: true )
  - if station_code
    = this.code.render_image( all: all_station_codes )
    HAML
  end

  def render_link_to_station_page_ja( set_anchor: false )
    if link_to_station_page_for_each_railway_line?
      r = railway_line_in_station_page
    else
      r = nil
    end

    h_locals = {
      this: self ,
      station_page_name: station_page_name ,
      railway_line: r ,
      # title: title.link_to_station_page.ja ,
      set_anchor: set_anchor ,
      datum_for_tooltip: datum_for_tooltip
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if railway_line.present?
  - if set_anchor
    %a{ datum_for_tooltip , href: url_for( action: :action_for_station_page , station: station_page_name , anchor: railway_line , only_path: true ) }<
      = this.render_name_ja
  - else
    - url = url_for( action: :action_for_station_page , station: station_page_name , railway_line: railway_line )
    %a{ datum_for_tooltip , href: url }<
      = this.render_name_ja
- else
  %a{ datum_for_tooltip , href: url_for( action: :action_for_station_page , station: station_page_name ) }<
    = this.render_name_ja
    HAML
  end

  def render_link_to_station_page_en
    h.link_to( name_en , station_page_name , datum_for_tooltip )
  end

  def render_link_to_station_facility_page_ja
    link_name = "#{ name_ja_actual }駅のご案内へジャンプします。"
    if add_anchor_to_link_to_station_facility_page_ja?
      url = h.url_for( controller: :station_facility , action: :action_for_station_page , station: station_page_name , anchor: anchor_added_to_link_of_station_faility_page )
    else
      url = h.url_for( controller: :station_facility , action: :action_for_station_page , station: station_page_name )
    end

    h.link_to( "" , url , name: link_name )
  end

  def render_latest_passenger_survey
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ id: :passenger_survey_of_station , class: :clearfix }
  %div{ class: :data }
    - icon_instance_of_passenger_survey = ::TokyoMetro::App::Renderer::Icon.passenger_survey( request , 1 )
    - url = url_for( controller: :passenger_survey , action: :action_for_station_page , station: this.object.name_in_system.underscore , anchor: nil )
    = link_to( icon_instance_of_passenger_survey.render , url , class: :icon )
    %div{ class: :text_ja }
      = this.latest_passenger_survey.decorate.render_journeys_of_each_station
    HAML
  end

  private

  def render_name_ja_or_hira( name_ja_or_hira , with_subname , prefix , suffix )
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja
    if regexp =~ name_ja_or_hira
      name_main = name_ja_or_hira.gsub( regexp , "" ).revive_machine_dependent_character
      name_sub = $1
    else
      name_main = name_ja_or_hira.revive_machine_dependent_character
      name_sub = nil
    end

    if prefix.present?
      name_main = prefix.to_s + name_main
    end

    h.render inline: <<-HAML , type: :haml , locals: { name_main: name_main , name_sub: name_sub , with_subname: with_subname , suffix: suffix }
- if name_sub.present? and with_subname
  = name_main
  %span{ class: :small }<>
    != name_sub
  - if suffix.present?
    = suffix
- elsif suffix.present?
  = ( name_main + suffix )
- else
  = name_main
    HAML
  end

  def name_with_station_code( station_name )
    str = ::String.new
    if station_code.present?
      str << "\[#{ station_code }\] "
    end
    str << station_name
    str
  end

  def link_to_station_page_for_each_railway_line?
    case @type_of_link_to_station
    when :must_link_to_railway_line_page , :must_link_to_railway_line_page_and_merge_yf
      true
    when :link_to_railway_line_page_if_containing_multiple_railway_lines
      has_another_railway_line_infos_of_tokyo_metro?
    when :link_to_railway_line_page_if_containing_multiple_railway_lines_and_merge_yf
      has_another_railway_line_infos_of_tokyo_metro? and !( between_wakoshi_and_kotake_mukaihara? )
    when nil
      false
    end
  end

  def add_anchor_to_link_to_station_facility_page_ja?
    @type_of_link_to_station = :link_to_railway_line_page_if_containing_multiple_railway_lines_and_merge_yf
    link_to_station_page_for_each_railway_line?
  end

  def railway_line_in_station_page
    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and object.between_wakoshi_and_kotake_mukaihara?
      "yurakucho_and_fukutoshin_line"
    elsif object.railway_line_info.is_branch_line?
      _branch = object.railway_line_info
      _main = _branch.main_railway_line_info
      _main.decorate.page_name
    else
      object.railway_line_info.decorate.page_name
    end
  end

  def anchor_added_to_link_of_station_faility_page
    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and object.between_wakoshi_and_kotake_mukaihara?
      "yurakucho_and_fukutoshin_line"
    else
      object.railway_line_info.decorate.page_name
    end
  end

  def datum_for_tooltip
    { 'data-station_code_images' => code.all.join( '/' ) , 'data-text_ja' => object.name_ja , 'data-text_hira' => object.name_hira , 'data-text_en' => object.name_en }
  end

end
