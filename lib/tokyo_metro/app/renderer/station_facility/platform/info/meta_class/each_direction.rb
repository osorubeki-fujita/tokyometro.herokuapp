class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::EachDirection < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , platform_infos , railway_lines , railway_direction )
    super( request )
    @platform_infos = platform_infos.sort_by( &:car_number )
    set_railway_line( railway_lines )
    @railway_direction = railway_direction
  end

  attr_reader :platform_infos
  attr_reader :railway_direction

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::Common

  def render
    if has_transfer_infos? or has_barrier_free_facility_infos? or has_surrounding_area_infos?
      h.render inline: <<-HAML , type: :haml , locals: h_locals
= info.render_direction_info
= info.render_infos_of_each_platform
      HAML
    end
  end

  def render_direction_info
    if @railway_direction.present?
      h.render inline: <<-HAML , type: :haml , locals: { railway_direction: @railway_direction }
%div{ class: :info_of_railway_direction }
  %div{ class: :title_of_direction }
    %h4{ class: :text_ja }<
      = railway_direction.station_info.decorate.render_name_ja( with_subname: true , suffix: "方面行きホーム" )
    %h5{ class: :text_en }<
      = railway_direction.station_info.decorate.render_name_en( with_subname: true , prefix: "Platform for " )
      HAML
    end
  end

  def render_infos_of_each_platform
    if has_one_car_composition_type?
      h.render inline: <<-HAML , type: :haml , locals: { this: self }
%table{ class: :platform_info }
  = this.render_car_number_array_if_one_car_composition_type
  - # 乗換路線がある場合は、乗換の情報を記述
  = this.render_transfer_infos
  - # 駅構内の施設がある場合は、駅構内の施設の情報を記述
  = this.render_barrier_free_facility_infos
  - # 駅周辺の情報がある場合は、駅周辺の情報を記述
  = this.render_surrounding_area_infos
      HAML
    else
      # h.platform_infos_of_each_platform( @platform_infos , railway_line_css_class_name , car_composition_types , has_transfer_infos? , has_barrier_free_facility_infos? , has_surrounding_area_infos? )
      raise "Error"
    end
  end

  def render_car_number_array_if_one_car_composition_type
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ info.railway_line_css_class_name , :car_numbers , :text_en ] }
  = ::StationFacilityPlatformInfoDecorator.render_an_empty_cell
  - ( 1..( info.max_car_composition ) ).each do | n |
    %td{ class: :car_number }<
      = n
    HAML
  end

  def render_transfer_infos
    if has_transfer_infos?
      hl = {
        request: request ,
        transfer_infos: transfer_infos
      }
      h.render inline: <<-HAML , type: :haml , locals: hl
%tr{ class: :transfer_infos }
  = ::StationFacilityPlatformInfoDecorator.render_transfer_info_title
  = ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::TransferInfos.new( request , transfer_infos ).render
      HAML
    end
  end

  def render_barrier_free_facility_infos
    if has_barrier_free_facility_infos?
      _barrier_free_facility_infos = barrier_free_facility_infos
      hl = {
        request: request ,
        inside: _barrier_free_facility_infos.map { | infos_of_each_car | infos_of_each_car.select( &:inside? ) } ,
        outside: _barrier_free_facility_infos.map { | infos_of_each_car | infos_of_each_car.select( &:outside? ) }
      }

      h.render inline: <<-HAML , type: :haml , locals: hl
- if inside.any?( &:present? )
  %tr{ class: :barrier_free_infos_inside }
    = ::StationFacilityPlatformInfoDecorator.render_inside_barrier_free_facility_title
    = ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::BarrierFreeFacilityInfos.new( request , inside ).render

- if outside.any?( &:present? )
  %tr{ class: :barrier_free_infos_outside }
    = ::StationFacilityPlatformInfoDecorator.render_outside_barrier_free_facility_title
    = ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::BarrierFreeFacilityInfos.new( request , outside ).render
      HAML
    end
  end

  def render_surrounding_area_infos
    if has_surrounding_area_infos?
      hl = {
        request: request ,
        surrounding_area_infos: surrounding_area_infos
      }
      h.render inline: <<-HAML , type: :haml , locals: hl
%tr{ class: :surrounding_areas }
  = ::StationFacilityPlatformInfoDecorator.render_surrounding_area_info_title
  = ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::TableRow::SurroundingAreaInfos.new( request , surrounding_area_infos ).render
      HAML
    end
  end

end