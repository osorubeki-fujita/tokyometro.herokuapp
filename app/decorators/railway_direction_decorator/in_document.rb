class RailwayDirectionDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%li{ class: [ :document_info_box , :railway_direction , :clearfix ] }
  = this.render_main_domain
  = this.render_button_domain
  = this.render_infos
    HAML
  end

  def render_main_domain
    h.render inline: <<-HAML , type: :haml , locals: { number: object.id , station_info_decorated: object.station_info.decorate }
%div{ class: [ :text , :main , :clearfix ] }
  %div{ class: [ :number , :text_en ] }<
    = number
  %div{ class: :text_ja }<
    = station_info_decorated.name_ja_actual
  %div{ class: :text_en }<
    = station_info_decorated.name_en
  %div{ class: [ :same_as , :text_en ] }<
    = station_info_decorated.same_as
    HAML
  end

  private

  def infos_to_render
    super().merge({
      "Infos from Db columns of station info object (partial)" => infos_from_db_columns_of_station_info_object ,
      "Infos from Db columns of railway line object (partial)" => infos_from_db_columns_of_railway_line_object
    })
  end

  def infos_from_db_columns_of_station_info_object
    infos_from_methods_of( object.station_info , :same_as , :station_code )
  end

  def infos_from_db_columns_of_railway_line_object
    infos_from_methods_of( object.railway_line , :same_as )
  end

end
