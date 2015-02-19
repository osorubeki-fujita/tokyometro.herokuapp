module BarrierFreeFacilityHelper

  def barrier_free_facility_infos
    h_locals = { facilities: @station_facility.barrier_free_facilities }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :station_facility_info }
  - # カテゴリで分類
  - facilities.group_by( &:barrier_free_facility_type_id ).sort_keys.each do | type_id , facilities_in_a_type |
    - # 個別のカテゴリ
    - facility_type = BarrierFreeFacilityType.find( type_id ).decorate
    %div{ class: facility_type.div_class_name }
      = facility_type.decorate.render_sub_title
      - # 場所で分類
      - facilities_in_a_type.group_by( &:barrier_free_facility_located_area_id ).sort_keys.each do | area_id , facilities_in_a_group |
        - # 個別の場所
        - if facilities_in_a_group.present?
          - facility_located_area = BarrierFreeFacilityLocatedArea.find( area_id ).decorate
          %div{ class: facility_located_area.div_class_name }
            = facility_located_area.decorate.render_sub_title
            - facilities_in_a_group.each do | item |
              = item.decorate.render
    HAML
  end

end