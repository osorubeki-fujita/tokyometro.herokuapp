class Station::InfoDecorator::InFareTable < TokyoMetro::Factory::Decorate::SubDecorator

  def render( starting_station_info: false )
    if starting_station_info
      h_locals = { this: self }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :starting_station] }<
  = this.render_name
      HAML

    else
      linked_page_name = decorator.page_name
      url = u.url_for( controller: :fare , railway_line: object.railway_line_info.decorate.page_name , station: linked_page_name , only_path: true )
      h_locals = { this: self , linked_page_name: linked_page_name , url: url }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :with_link ] , "data-href" => linked_page_name }<
  = link_to( "" , url )
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
