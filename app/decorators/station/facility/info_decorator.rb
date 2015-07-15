class Station::Facility::InfoDecorator < Draper::Decorator
  delegate_all

  decorates_association :station_infos
  decorates_association :barrier_free_facility_infos

  include CommonTitleRenderer

  def self.common_title_ja
    "駅のご案内"
  end

  def self.common_title_en
    "Information of station and its facilities"
  end

  def render_barrier_free_facility_infos
    h.render inline: <<-HAML , type: :haml , locals: { facility_infos: object.barrier_free_facility_infos }
%ul{ id: :station_facility_info }
  - # カテゴリで分類
  - facility_infos.group_by( &:type_id ).sort_keys.each do | type_id , facility_infos_in_a_type |
    - # 個別のカテゴリ
    - facility_type = ::BarrierFreeFacility::Type.find( type_id ).decorate
    %li{ class: facility_type.ul_class_name }
      = facility_type.render_sub_title
      - # 場所で分類
      - facility_infos_in_a_type.group_by( &:located_area_id ).sort_keys.each do | area_id , facility_infos_in_a_group |
        - # 個別の場所
        - if facility_infos_in_a_group.present?
          - facility_located_area = BarrierFreeFacility::LocatedArea.find( area_id ).decorate
          %ul{ class: facility_located_area.ul_class_name }
            = facility_located_area.render_sub_title
            - facility_infos_in_a_group.each do | item |
              = item.decorate.render
    HAML
  end

end
