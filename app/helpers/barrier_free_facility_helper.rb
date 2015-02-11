module BarrierFreeFacilityHelper

  def barrier_free_infos_top_title
    render inline: <<-HAML , type: :haml
%div{ class: :top_title }
  %h2{ class: :text_ja }<
    = "駅施設のご案内"
  %h3{ class: :text_en }<
    = "Information of station facilities"
    HAML
  end

  def barrier_free_facility_infos( facility )
    # カテゴリで分類
    h_locals = { barrier_free_facilities_grouped_by_type: facility.barrier_free_facilities.group_by { | facility | facility.barrier_free_facility_type.id } }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :station_facility_info }
  - barrier_free_facilities_grouped_by_type.keys.sort.each do | type_id |
    - # 個別のカテゴリ
    - barrier_free_facilities_in_a_type = barrier_free_facilities_grouped_by_type[ type_id ]
    - type_instance = ::BarrierFreeFacilityType.find( type_id )
    %div{ class: type_instance.name_en.underscore }
      - # 施設のカテゴリを記述
      %div{ class: :title }
        %div{ class: :text_ja }<
          = type_instance.name_ja
          %span{ class: :text_en }<
            = type_instance.name_en
      - # 場所で分類
      - facilities_grouped_by_located_area = barrier_free_facilities_in_a_type.group_by { | facility | facility.barrier_free_facility_located_area.name_ja }
      - inside_key = "改札内"
      - outside_key = "改札外"
      - # 改札内の施設について
      - if facilities_grouped_by_located_area[ inside_key ].present?
        %div{ class: :inside }
          %div{ class: :title }
            %div{ class: :text_ja }<>
              = inside_key
              %span{ class: :text_en }<
                = "Inside"
          - facilities_grouped_by_located_area[ inside_key ].each do | facility |
            = barrier_free_facility_info_precise( facility )
      - # 改札外の施設について
      - if facilities_grouped_by_located_area[ outside_key ].present?
        %div{ class: :outside }
          %div{ class: :title }
            %div{ class: :text_ja }<>
              = outside_key
              %span{ class: :text_en }<
                = "Outside"
          - facilities_grouped_by_located_area[ outside_key ].each do | facility |
            = barrier_free_facility_info_precise( facility )
    HAML
  end

  private

  def barrier_free_facility_info_precise( facility )
    render inline: <<-HAML , type: :haml , locals: { facility: facility }
%div{ class: :facility }
  = barrier_free_facility_place_name_number( facility )
  %div{ class: :info }
    = barrier_free_facility_place_name( facility )
    = barrier_free_facility_service_details( facility )
    - # 車いす対応か否かの情報
    = barrier_free_facility_available_to_wheel_chair( facility )
    - # トイレ設備
    = barrier_free_facility_toilet_assistant( facility )
    - # 特記事項
    - if facility.remark.present?
      = barrier_free_facility_remark( facility )
    HAML
  end

  # 駅施設の番号を記述するメソッド
  def barrier_free_facility_place_name_number( facility )
    id_and_code = facility.id_and_code_hash
    facility_id , facility_code = id_and_code[ :id ] , id_and_code[ :code ]

    h_locals = { facility_id: facility_id , facility_code: facility_code }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: facility_id , class: [ :number , :text_en ] }<
  = facility_code
    HAML
  end

  # 駅施設の位置を記述するメソッド
  # @param barrier_free_facility [StationFacility] 駅施設のインスタンス
  def barrier_free_facility_place_name( barrier_free_facility )
    root_infos = barrier_free_facility.root_infos
    render inline: <<-HAML , type: :haml , locals: { root_infos: root_infos }
- if root_infos.present?
  %div{ class: :place }<
    - root_infos = root_infos.sort_by { | root_info | root_info.index_in_root }
    - root_infos = root_infos.map { | root_info | root_info.barrier_free_facility_place_name.name_ja.zen_num_to_han.convert_comma_between_number }
    = root_infos.join( " ～ " )
    HAML
  end

  # 駅施設の詳細（利用可能日、利用可能時間など）を記述するメソッド
  # @param barrier_free_facility [StationFacility] 駅施設のインスタンス
  def barrier_free_facility_service_details( barrier_free_facility )
    service_details = barrier_free_facility.barrier_free_facility_service_details
    h_locals = { service_details: service_details }

    render inline: <<-HAML , type: :haml , locals: h_locals
- if service_details.present?
  %div{ class: :service_details }
    - service_details.each do | service_detail |
      %div{ class: :service_detail }<
        - if service_detail.has_any_info?
          - pattern = service_detail.barrier_free_facility_service_detail_pattern
          - # 利用可能日
          - if pattern.operation_day_id.meaningful?
            %div{ class: :operation_day }<
              = pattern.operation_day.name_ja
          - # エスカレーターの方向
          - if service_detail.has_escalator_direction_info?
            - escalator_direction = service_detail.escalator_direction
            %div{ class: :escalator_directions }<
              - if escalator_direction.only_up?
                %div{ class: :escalator_direction }<
                  = "上り"
              - if escalator_direction.only_down?
                %div{ class: :escalator_direction }<
                  = "下り"
              - if escalator_direction.both?
                %div{ class: :escalator_direction }<
                  = "上り・下り"
          - # 利用可能時間
          - if pattern.has_service_time_info?
            %div{ class: :service_time }<
              = "利用可能時間：" + pattern.service_time_info( skip_validity_check: true )
    HAML
  end

  def barrier_free_facility_available_to_wheel_chair( facility )
    if facility.escalator_available_to_wheel_chair?
      render inline: <<-HAML , type: :haml
%div{ class: :wheel_chair }<
  = "車いす対応"
      HAML
    end
  end

  def barrier_free_facility_toilet_assistant( facility )
    toilet_assistant_info = facility.toilet_assistant_info
    if toilet_assistant_info.present?
      render inline: <<-HAML , type: :haml , locals: { toilet_assistant_info: toilet_assistant_info }
%div{ class: :toilet_assistants }<
  - ary = toilet_assistant_info.to_a
  - if ary.present?
    - ary.each do | assistant |
      %div{ class: :toilet_assistant }<
        = assistant
      HAML
    end
  end

  def barrier_free_facility_remark( facility )
    if facility.remark.present?
      render inline: <<-HAML , type: :haml , locals: { remark_array: facility.remark_to_a }
%div{ class: :remark }
  - remark_array.each do | str |
    %p<
      = str
      HAML
    end
  end

end