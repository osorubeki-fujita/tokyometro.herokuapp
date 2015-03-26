class RailwayLineDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer
  extend SubTopTitleRenderer

  include TwitterRenderer
  include CssClassNameOfConnectingRailwayLine
  include RenderLinkToRailwayLinePage

  def self.common_title_ja
    "路線のご案内"
  end

  def self.common_title_en
    "Information of railway lines"
  end

  # タイトルのメイン部分（路線色・路線名）を記述するメソッド
  def self.name_main( railway_lines )
    class << railway_lines
      include ForRails::RailwayLineArrayModule
    end

    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ class: :main_text }
  - # タイトルの路線名を記述
  %div{ class: infos.to_title_color_class }
    %h2{ class: :text_ja }<
      = infos.to_railway_line_name_text_ja
    %h3{ class: :text_en }<
      = infos.to_railway_line_name_text_en
    HAML
  end

  def self.render_title_of_railway_lines( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :railway_line_title }
  = ::RailwayLineDecorator.render_common_title
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_train_info
    render_sub_top_title( text_ja: "運行情報" , text_en: "Train information" )
  end

  # タイトルを記述するメソッド（路線別）
  def self.render_title_of_passenger_survey( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :railway_line )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_station_facility( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :station_facility_title }
  = ::StationFacilityDecorator.render_common_title
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  # 列車位置情報のタイトルを記述するメソッド
  def self.render_title_of_train_location( railway_lines )
    render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :train_location_title }
  = ::TrainLocationDecorator.render_common_title
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_station_timetable( railway_lines )
    render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :station_timetable_title }
  = ::StationTimetableDecorator.render_common_title
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_railway_timetable( railway_lines )
    render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :railway_timetable_title }
  = render_common_title( common_title_ja: ::RailwayTimetableHelper.common_title_ja , common_title_en: ::RailwayTimetableHelper.common_title_en )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_travel_time_simple_infos_of_multiple_railway_lines( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
- railway_lines.each do | railway_line |
  %div{ class: :railway_line }
    = railway_line.decorate.render_travel_time_simple_infos
    HAML
  end

  def self.render_matrixes_of_all_railway_lines( including_yurakucho_and_fukutoshin: false , make_link_to_railway_line: true )
    h_locals = {
      including_yurakucho_and_fukutoshin: including_yurakucho_and_fukutoshin ,
      make_link_to_railway_line: make_link_to_railway_line
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :railway_line_matrixes }
  - ::RailwayLine.tokyo_metro( including_branch_line: false ).each do | railway_line |
    = railway_line.decorate.render_matrix( make_link_to_railway_line: make_link_to_railway_line )
  - if including_yurakucho_and_fukutoshin
    = ::RailwayLineDecorator.render_matrix_of_yurakucho_and_fukutoshin( make_link_to_railway_line )
    HAML
  end

  def self.render_matrix_of_yurakucho_and_fukutoshin( make_link_to_railway_line )
    h_locals = { make_link_to_railway_line: make_link_to_railway_line }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line_matrix , :multiple_lines , :yurakucho_fukutoshin ] }
  - if make_link_to_railway_line
    = link_to( "" , "yurakucho_and_fukutoshin_line" )
  %div{ class: :info }
    %div{ class: :railway_line_codes }<
      %div{ class: :railway_line_code_block }
        - [ ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Yurakucho" ) , ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Fukutoshin" ) ].each do | railway_line |
          %div{ class: railway_line.css_class_name }<
            %div{ class: :railway_line_code_outer }<
              = railway_line.decorate.render_railway_line_code
    %div{ class: :text_ja }<
      = "有楽町線・副都心線"
    %div{ class: :text_en }<
      = "Yurakucho and Fukutoshin Line"
    HAML
  end
  
  def self.render_women_only_car_infos_of_multiple_railway_lines( railway_lines )
    infos = ::WomenOnlyCarInfo.where( railway_line_id: railway_lines.pluck( :id ) ).includes( :operation_day , :from_station_info , :to_station_info )
    if infos.present?

      class << infos
        include ::ForRails::WomenOnlyCarInfos
      end

      h.render inline: <<-HAML , type: :haml , locals: { infos: infos }
%div{ id: :women_only_car }
  = ::WomenOnlyCarInfoDecorator.render_sub_top_title
  - if infos.have_only_one_railway_line?
    - railway_line = infos.only_one_railway_line
    = railway_line.decorate.render_women_only_car_infos_in_a_railway_line( infos , in_group_of_multiple_railway_line: false )
  - else
    - infos.group_by( &:railway_line_id ).each do | railway_line_id , infos_of_a_railway_line |
      = ::RailwayLine.find( railway_line_id ).decorate.render_women_only_car_infos_in_a_railway_line( infos_of_a_railway_line , in_group_of_multiple_railway_line: true )
      HAML
    end
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

  def twitter_title
    "Twitter #{ object.name_ja } 運行情報"
  end

  def railway_line_in_station_facility_platform_info_transfer_info
    case same_as
    when "odpt.Railway:Tobu.SkyTreeIsesaki"
      "東武線"
    when "odpt.Railway:Seibu.SeibuYurakucho"
      "西武線"
    else
      object.name_ja_with_operator_name
    end
  end

  def railway_line_page_name
    if object.branch_line?
      "#{ css_class_name }_line".gsub( /_branch/ , "" ) 
    else
      "#{ css_class_name }_line"
    end
  end
  
  def travel_time_table_id
    css_class_name + "_travel_time"
  end

  def station_facility_platform_info_tab_name
    "platform_info_#{css_class_name}"
  end

  def render_name( process_special_railway_line: true )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , process_special_railway_line: process_special_railway_line }
%div{ class: :text }<
  = info.render_name_base( process_special_railway_line: true )
    HAML
  end

  def render_name_base( process_special_railway_line: true )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , process_special_railway_line: process_special_railway_line }
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
    = ::WomenOnlyCarInfoDecorator.render_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line )
- else
  %div{ class: info.css_class_name }
    = ::WomenOnlyCarInfoDecorator.render_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line )
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

  def render_travel_time_simple_infos
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- info.travel_time_infos.each do | travel_time_info |
  = travel_time_info.decorate.render_simple_info
    HAML
  end

  def render_in_pages_related_to_station
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
= info.render_railway_line_code( must_display_line_color: true , small: true )
= info.render_name( process_special_railway_line: true )
    HAML
  end

  alias :render_in_station_info_of_travel_time_info :render_in_pages_related_to_station

  def render_connecting_railway_line_info_in_station_facility
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: info.css_class_name_of_connecting_railway_line }<
  = info.render_link_to_railway_line_page
  = info.render_in_pages_related_to_station
    HAML
  end

  def render_railway_line_code( must_display_line_color: true , small: false )
    h_locals = {
      letter: railway_line_code_letter ,
      must_display_line_color: must_display_line_color ,
      class_name: css_class_name_of_railway_line_code( small ) ,
      small: small
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if letter.present?
  %div{ class: class_name }<
    %p<
      = letter
- elsif must_display_line_color
  = color_box( small: small )
- else
  %div{ class: class_name }<
    HAML
  end

  def render_railway_line_code_code_outer
    if name_code.present?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :railway_line_code_outer }
  = info.render_railway_line_code
      HAML
    end
  end

  def render_matrix( make_link_to_railway_line: true , size: :normal )
    case size
    when :normal
      class_names = [ :railway_line_matrix , :each_line , css_class_name ]
    when :small
      class_names = [ :railway_line_matrix_small , :each_line , css_class_name ]
    end

    h_locals = {
      info: self ,
      make_link_to_railway_line: make_link_to_railway_line ,
      size: size ,
      class_names: class_names
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_names }
  - if make_link_to_railway_line
    = link_to( "" , info.railway_line_page_name )
  - case size
  - when :normal
    %div{ class: :info }
      = info.render_railway_line_code_code_outer
      = info.render_name_base( process_special_railway_line: true )
  - when :small
    %div{ class: :info }
      = info.render_railway_line_code_code_outer
      = info.render_name( process_special_railway_line: true )
    HAML
  end

  def render_station_facility_platform_info_transfer_info_tab
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- tab_name = info.station_facility_platform_info_tab_name
%li{ class: [ tab_name , :platform_info_tab ] }<
  - # = ::StationFacilityPlatformInfoDecorator.render_link_in_tab( tab_name )
  - # %div{ class: :railway_line_name }
  %div{ class: :railway_line_name , onclick: raw( "changeStationFacilityPlatformInfoTabByPageLink('" + tab_name.to_s + "' , true ) ; return false ; " ) }
    %div{ class: info.css_class_name }
      = info.render_railway_line_code( small: true )
    = info.render_name
    HAML
  end

  def render_matrix_and_links_to_stations( make_link_to_railway_line , type_of_link_to_station )
    @type_of_link_to_station = type_of_link_to_station
    h_locals = {
      info: self ,
      make_link_to_railway_line: make_link_to_railway_line
    }
  
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :railway_line }
  = info.render_matrix( make_link_to_railway_line: make_link_to_railway_line , size: :small )
  - case info.same_as
  - when "odpt.Railway:TokyoMetro.Marunouchi"
    = info.render_matrix_and_links_to_stations_of_railway_line_including_branch( ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" ) )
  - when "odpt.Railway:TokyoMetro.Chiyoda"
    = info.render_matrix_and_links_to_stations_of_railway_line_including_branch( ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ) )
  - else
    %div{ class: :stations }
      = info.render_matrix_and_links_to_stations_of_normal_railway_line
    HAML
  end

  # 通常の路線の駅一覧を書き出す
  def render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: @type_of_link_to_station )
    h_locals = {
      info: self ,
      type_of_link_to_station: type_of_link_to_station
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- info.station_infos.each do | station_info |
  = station_info.decorate.render_link_to_station_in_matrix( type_of_link_to_station )
    HAML
  end

  # 支線を含む路線の駅一覧を書き出す
  def render_matrix_and_links_to_stations_of_railway_line_including_branch( branch_line )
    h_locals = {
      info: self , branch_line: branch_line ,
      type_of_link_to_station: @type_of_link_to_station
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :stations_on_main_line }
  = info.render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: type_of_link_to_station )
%div{ class: :stations_on_branch_line }
  = branch_line.decorate.render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: type_of_link_to_station )
    HAML
  end

  def render_fare_table_row_of_starting_station_info( station_infos_of_this_instance )
    starting_station_info = station_infos_of_this_instance.find_by( railway_line_id: self.id )
    raise "Error" if starting_station_info.nil?
    h.render inline: <<-HAML , type: :haml , locals: { info: starting_station_info.decorate }
%tr<
  = info.render_in_fare_table( starting_station_info: true )
  %td{ class: :starting_station , colspan: 4 }<
    %div{ class: :text_ja }
      = "この駅からの運賃を表示しています"
    %div{ class: :text_en }
      = "Fares from this station are displayed now."
    HAML
  end

  def render_train_information( type )
    render inline: <<-HAML , type: :haml , locals: { info: self , type: type }
%div{ class: :train_information }
  = info.render_matrix( make_link_to_railway_line: false , size: :small )
  - case type
  - when :on_time
    = ::TrainInformationDecorator.render_info( :on_time , additional_info: nil )
  - when :nearly_on_time
    = ::TrainInformationDecorator.render_info( :nearly_on_time , additional_info: "遅れ：最大 1分30秒" )
  - when :delay
    = ::TrainInformationDecorator.render_info( :delay , additional_info: "遅れ：最大 15分" )
  - when :suspended
    = ::TrainInformationDecorator.render_info( :suspended , additional_info: "運転再開予定：15:30"  )
  - when :remark
    = remark
    HAML
  end

  def render_train_information_test
    render inline: <<-HAML , type: :haml , locals: { info: self }
- [ :on_time , :nearly_on_time , :delay , :suspended ].each do | status_type |
  = info.render_train_information( status_type )
    HAML
  end

  # 各路線のすべての駅への運賃
  # @param station_infos_of_this_instance [Array <Station::Info>] 駅（複数、同名）のインスタンスのリスト（複数路線がある場合は、各路線のインスタンスを保持）
  # @param starting_station_info [Station::Info] 運賃表の基準駅のインスタンス
  def render_fare_table( station_infos_of_this_instance , starting_station_info , fares , normal_fare_groups )

    # 路線のインスタンス railway_line に、
    # station_infos_of_this_instance の要素である駅（路線別）が含まれている場合は、その駅の id を返す。
    # 含まれていない場合は、nil
    class << self
      include ForRails::FareTable::StartingStationInfoIdIncludedInThisRailwayLine
    end

    id_of_starting_station_info_id_included_in_this_railway_line = self.fare_table_starting_station_info_id_included_in_this_railway_line( station_infos_of_this_instance )

    h_locals = {
      info: self ,
      station_infos_of_this_instance: station_infos_of_this_instance ,
      id_of_starting_station_info_id_included_in_this_railway_line: id_of_starting_station_info_id_included_in_this_railway_line ,
      starting_station_info: starting_station_info ,
      fares: fares ,
      normal_fare_groups: normal_fare_groups
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%table{ class: [ :fare_table , info.css_class_name ] }
  - # ヘッダーの作成
  = ::FareDecorator.render_header_of_fare_table
  - station_infos_in_this_railway_line = info.station_infos.order( :index_in_railway_line )
  - # 路線のインスタンス info に station_infos_of_this_instance の要素である駅（路線別）が含まれている場合
  - if id_of_starting_station_info_id_included_in_this_railway_line.present?
    - class << station_infos_in_this_railway_line
      - include ForRails::FareTable::SplitStationInfosByStartingStationInfoId
    - group_of_stations = station_infos_in_this_railway_line.fare_table_split_station_infos_by_starting_station_info_id( id_of_starting_station_info_id_included_in_this_railway_line )
    - before_starting_station_info = group_of_stations[0]
    - after_starting_station_info = group_of_stations[1]
    - #
    - if starting_station_info.nil?
      - err_msg = "Error: Station::Info.find( " + id_of_starting_station_info_id_included_in_this_railway_line.to_s + " ) is not valid."
    - #
    = fare_table_make_rows( fares , before_starting_station_info , normal_fare_groups , make_empty_row_when_no_station: true )
    = info.render_fare_table_row_of_starting_station_info( station_infos_of_this_instance )
    = fare_table_make_rows( fares , after_starting_station_info , normal_fare_groups )
    - #
    - # 路線のインスタンス info に station_infos_of_this_instance の要素である駅（路線別）が含まれていない場合
  - else
    = fare_table_make_rows( fares , station_infos_in_this_railway_line , normal_fare_groups )
    HAML
  end

  def render_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: [ :document_info_box_normal , info.css_class_name ] }
  %div{ class: :top }
    = color_box
    = info.render_railway_line_code( must_display_line_color: false )
    = info.render_color_info_in_document
  %div{ class: :railway_line_name }
    = info.render_name_ja_in_document_info_box
    = info.render_name_en_in_document_info_box
    HAML
  end

  def render_color_info_in_document
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :color_info }
  %div{ class: :web_color }<
    = info.color
  - if info.color.present?
    %div{ class: :rgb_color }<
      = ::ApplicationHelper.rgb_in_parentheses( info.color )
    HAML
  end
  
  def render_name_ja_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- regexp = ::ApplicationHelper.regexp_for_parentheses_normal
- railway_line_name_ja = info.name_ja_with_operator_name_precise
%div{ class: :text_ja }<
  - if regexp =~ railway_line_name_ja
    - out_of_parentheses = railway_line_name_ja.gsub( regexp , "" )
    - in_parentheses =  $1
    %div{ class: :main }<
      = out_of_parentheses
    %div{ class: :sub }<
      = in_parentheses
  - else
    = railway_line_name_ja
    HAML
  end

  def render_name_en_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- regexp = ApplicationHelper.regexp_for_parentheses_normal
- railway_line_name_en = info.name_en_with_operator_name_precise
%div{ class: :text_en }<
  - if regexp =~ railway_line_name_en
    - out_of_parentheses = railway_line_name_en.gsub( regexp , "" )
    - in_parentheses =  $1
    %div{ class: :main }<
      = out_of_parentheses
    %div{ class: :sub }<
      = in_parentheses
  - else
    = railway_line_name_en
    HAML
  end

  private

  def railway_line_code_letter
    if name_code.instance_of?( ::String )
      name_code
    else
      nil
    end
  end

  def css_class_name_of_railway_line_code( small )
    if small
      :railway_line_code_32
    else
      :railway_line_code_48
    end
  end

  def railway_line_decorated
    self
  end

  def railway_line_page_exists?
    object.tokyo_metro?
  end

  def set_anchor_in_travel_time_info_table?
    object.branch_line?
  end

end