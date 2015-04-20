class TokyoMetro::App::Renderer::StationCode::Normal < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , station_infos , first_info: nil )
    super( request )
    @station_infos = [ station_infos ].flatten
    
    if @station_infos.all?( &:at_ayase? ) or @station_infos.all?( &:at_nakano_sakaue? )
      @station_infos = [ @station_infos.first ]
    end
    @first_info = first_info
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :station_codes }<
  - if first_info.present?
    = first_info.decorate.render_each_station_code_image_tag
    - other_station_infos = station_infos.select { | info | info.id != first_info.id }
    - if other_station_infos.present?
      - other_station_infos.each do | info |
        = info.decorate.render_each_station_code_image_tag
  - else
    - station_infos.each do | info |
      = info.decorate.render_each_station_code_image_tag
    HAML
  end

  private

  def h_locals
    super.merge({
      station_infos: @station_infos ,
      first_info: @first_info
    })
  end
  
end