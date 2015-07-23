class Station::InfoDecorator::InFareTable < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render( starting_station_info: false )
    if starting_station_info
      h_locals = { this: self }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :starting_station] }<
  = this.render_name
      HAML

    else
      h_locals = { this: self , linked_page_name: object.name_in_system.underscore }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :with_link ] , "data-href" => linked_page_name }<
  - linked_page = url_for( railway_line: this.railway_line_info.decorate.page_name , station: linked_page_name )
  = link_to( "" , linked_page )
  = this.render_name
      HAML
    end
  end

  def render_name
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ class: :station_info_domain }
  %div{ class: :station_code_outer }
    = d.code.render_image( all: false )
  %div{ class: [ :text , :clearfix ] }
    = d.render_name_ja_and_en
    HAML
  end

end
