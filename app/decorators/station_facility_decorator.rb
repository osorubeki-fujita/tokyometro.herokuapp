class StationFacilityDecorator < Draper::Decorator
  delegate_all

  decorates_association :stations
  decorates_association :barrier_free_facilities

  include CommonTitleRenderer

  def self.common_title_ja
    "駅のご案内"
  end

  def self.common_title_en
    "Information of station and its facilities"
  end

  def render_barrier_free_facility_infos
    h.render inline: <<-HAML , type: :haml , locals: { facilities: self.barrier_free_facilities }
%div{ id: :station_facility_info }
  - # カテゴリで分類
  - facilities.group_by( &:barrier_free_facility_type_id ).sort_keys.each do | type_id , facilities_in_a_type |
    - # 個別のカテゴリ
    - facility_type = ::BarrierFreeFacilityType.find( type_id ).decorate
    %div{ class: facility_type.div_class_name }
      = facility_type.render_sub_title
      - # 場所で分類
      - facilities_in_a_type.group_by( &:barrier_free_facility_located_area_id ).sort_keys.each do | area_id , facilities_in_a_group |
        - # 個別の場所
        - if facilities_in_a_group.present?
          - facility_located_area = BarrierFreeFacilityLocatedArea.find( area_id ).decorate
          %div{ class: facility_located_area.div_class_name }
            = facility_located_area.render_sub_title
            - facilities_in_a_group.each do | item |
              = item.render
    HAML
  end

end