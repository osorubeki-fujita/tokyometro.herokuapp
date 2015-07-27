class Railway::Line::InfoDecorator::Matrix < TokyoMetro::Factory::Decorate::SubDecorator

  def self.render_all_railway_line_infos( request , including_yurakucho_and_fukutoshin: false , make_link_to_railway_line: true , controller_of_linked_page: nil )
    h_locals = {
      request: request ,
      including_yurakucho_and_fukutoshin: including_yurakucho_and_fukutoshin ,
      make_link_to_railway_line: make_link_to_railway_line ,
      controller_of_linked_page: controller_of_linked_page
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :railway_line_matrixes , class: :clearfix }
  - ::Railway::Line::Info.tokyo_metro( including_branch_line: false ).each do | railway_line_info |
    = railway_line_info.decorate.matrix.on( request ).render_normally( make_link_to_railway_line: make_link_to_railway_line , controller_of_linked_page: controller_of_linked_page )
  - if including_yurakucho_and_fukutoshin
    = ::Railway::Line::InfoDecorator::Matrix.render_yurakucho_and_fukutoshin( make_link_to_railway_line )
    HAML
  end

  def self.render_yurakucho_and_fukutoshin( make_link_to_railway_line )
    h_locals = {
      make_link_to_railway_line: make_link_to_railway_line ,
      railway_line_infos: [
        ::Railway::Line::Info.find_by_same_as( "odpt.Railway:TokyoMetro.Yurakucho" ) ,
        ::Railway::Line::Info.find_by_same_as( "odpt.Railway:TokyoMetro.Fukutoshin" )
      ]
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line_matrix , :multiple_lines , :yurakucho_fukutoshin ] }
  - if make_link_to_railway_line
    = link_to( "" , "yurakucho_and_fukutoshin_line" )
  %div{ class: :info }
    %div{ class: :railway_line_codes }<
      %div{ class: :railway_line_code_block }
        - railway_line_infos.each do | railway_line_info |
          %div{ class: railway_line_info.css_class }<
            %div{ class: :railway_line_code_outer }<
              = railway_line_info.decorate.code_domain.render
    %div{ class: :text_ja }<
      = "有楽町線・副都心線"
    %div{ class: :text_en }<
      = "Yurakucho and Fukutoshin Line"
    HAML
  end

  def render_normally( make_link_to_railway_line: true , controller_of_linked_page: nil , size: :normal )

    _class_of_normal_matrix_domain = class_of_normal_matrix_domain( size )
    url = url_of_link_on_normal_matrix( make_link_to_railway_line , controller_of_linked_page )

    h_locals = {
      this: self ,
      class_of_normal_matrix_domain: _class_of_normal_matrix_domain ,
      url: url ,
      small_railway_line_code: ( size == :very_small )
    }

    case size
    when :normal , :small , :very_small
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_of_normal_matrix_domain }
  - if url.present?
    = link_to( "" , url )
  %div{ class: [ :info , :clearfix ] }
    = this.code_domain.render_with_outer_domain( small: small_railway_line_code )
    = this.render_name( process_special_railway_line: true )
      HAML
    end
  end

  def render_with_links_to_stations( make_link_to_railway_line , type_of_link_to_station , set_anchor , controller_of_linked_page: nil )
    @type_of_link_to_station = type_of_link_to_station
    h_locals = {
      this: self ,
      make_link_to_railway_line: make_link_to_railway_line ,
      set_anchor: set_anchor ,
      type_of_link_to_station: @type_of_link_to_station ,
      controller_of_linked_page: controller_of_linked_page
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line , :clearfix ] }
  = this.render_normally( make_link_to_railway_line: make_link_to_railway_line , controller_of_linked_page: controller_of_linked_page , size: :small )
  - case this.object.same_as
  - when "odpt.Railway:TokyoMetro.Marunouchi"
    = this.render_with_links_to_stations_of_railway_line_including_branch( ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" ) , controller_of_linked_page , set_anchor )
  - when "odpt.Railway:TokyoMetro.Chiyoda"
    = this.render_with_links_to_stations_of_railway_line_including_branch( ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ) , controller_of_linked_page , set_anchor )
  - else
    %ul{ class: [ :stations , :text_ja , :clearfix ] }
      = this.render_with_links_to_stations_of_normal_railway_line( type_of_link_to_station , controller_of_linked_page , set_anchor )
    HAML
  end

  # 通常の路線の駅一覧を書き出す
  def render_with_links_to_stations_of_normal_railway_line( type_of_link_to_station , controller_of_linked_page , set_anchor )
    h_locals = {
      station_infos: station_infos ,
      type_of_link_to_station: type_of_link_to_station ,
      controller_of_linked_page: controller_of_linked_page ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- station_infos.each do | station_info |
  = station_info.decorate.in_matrix.render( type_of_link_to_station , controller_of_linked_page , set_anchor )
    HAML
  end

  # 支線を含む路線の駅一覧を書き出す
  def render_with_links_to_stations_of_railway_line_including_branch( branch_line , controller_of_linked_page , set_anchor )
    h_locals = {
      this: self ,
      branch_line: branch_line ,
      type_of_link_to_station: @type_of_link_to_station ,
      controller_of_linked_page: controller_of_linked_page ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ class: [ :stations_on_main_line , :text_ja , :clearfix ] }
  = this.render_with_links_to_stations_of_normal_railway_line( type_of_link_to_station , controller_of_linked_page , set_anchor )
%ul{ class: [ :stations_on_branch_line , :text_ja , :clearfix ] }
  = branch_line.decorate.matrix.on( request ).render_with_links_to_stations_of_normal_railway_line( type_of_link_to_station , controller_of_linked_page , set_anchor )
    HAML
  end

  private

  def class_of_normal_matrix_domain( size )
    case size
    when :normal
      class_names = [ :railway_line_matrix , :each_line , object.css_class ]
    when :small
      class_names = [ :railway_line_matrix_small , :each_line , object.css_class ]
    when :very_small
      class_names = [ :railway_line_matrix_very_small , :each_line , object.css_class ]
    else
      raise "Error: size settings \' :#{ size } \' is not valid."
    end
  end

  def url_of_link_on_normal_matrix( make_link_to_railway_line , controller_of_linked_page )
    url_h = {}
    if make_link_to_railway_line
      if controller_of_linked_page.present?
        if controller_of_linked_page == :passenger_survey
          action = :action_for_railway_line_or_year_page
        else
          action = :action_for_railway_line_page
        end
        url_h = { controller: controller_of_linked_page , action: action , railway_line: decorator.page_name }
      else
        url_h = { action: page_name }
      end
    end

    unless current_page?( url_h )
      return u.url_for( url_h.merge( { only_path: true } ) )
    end

    return nil
  end

end
