class BarrierFreeFacilityDecorator < Draper::Decorator
  delegate_all
  
  decorates_association :barrier_free_facility_type
  decorates_association :barrier_free_facility_located_area
  decorates_association :barrier_free_facility_root_infos
  decorates_association :barrier_free_facility_place_names
  decorates_association :barrier_free_facility_service_details
  decorates_association :barrier_free_facility_service_detail_patterns
  decorates_association :barrier_free_facility_escalator_directions
  decorates_association :barrier_free_facility_toilet_assistants
  decorates_association :barrier_free_facility_toilet_assistant_patterns

  extend SubTopTitleRenderer

  def self.sub_top_title_ja
    "駅施設のご案内"
  end

  def self.sub_top_title_en
    "Information of station facilities"
  end

  # 個々の駅施設の記号を返すメソッド
  # @return [Hash]
  def id_and_code_hash
    regexp = /\Aodpt\.StationFacility\:TokyoMetro\.(\w+)\.(?:\w+)\.(Inside|Outside)\.(\w+)/
    if regexp =~ same_as.to_s
      railway_line_name = $1
      railway_line_code = ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.#{ railway_line_name }" ).name_code

      place = $2
      category = $3
      if /\A\.(\d+)\Z/ =~ same_as.to_s.gsub( regexp , "" )
        number = $1
      else
        number = nil
      end
    else
      raise "Error: " + same_as
    end

    facility_id = [ place.downcase , category.downcase , number ].select( &:present? ).map( &:to_s ).join( "_" )
    facility_code = [ railway_line_code , number ].map( &:to_s ).join
    platform = [ place , category , number ].select( &:present? ).map( &:to_s ).join( "." )
    { :id => facility_id , :code => facility_code , :platform => platform }
  end

  def root_infos_to_s
    _root_infos = barrier_free_facility_root_infos
    if _root_infos.present?
      _root_infos.sort_by( &:index_in_root ).map( &:barrier_free_facility_place_name ).map( &:decorate ).map( &:name_ja_for_display ).join( " ～ " )
    else
      nil
    end
  end

  def remark_to_a
    remark.gsub( /。([\(（].+?[\)）])/ ) { "#{$1}。" }.gsub( /(?<=。)\n?[ 　]?/ , "\n" ).gsub( "出きません" , "できません" ).split( /\n/ )
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: { facility: self }
%div{ class: :facility }
  = facility.render_place_name_number
  %div{ class: :info }
    = facility.render_place_name
    = facility.render_service_details
    - # 車いす対応か否かの情報
    = facility.render_wheel_chair_info
    - # トイレ設備
    = facility.render_toilet_assistant
    - # 特記事項
    = facility.render_remark
    HAML
  end

  # 駅施設の番号を記述するメソッド
  def render_place_name_number
    id_and_code = id_and_code_hash
    h_locals = { id: id_and_code[ :id ] , code: id_and_code[ :code ] }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: id , class: [ :number , :text_en ] }<
  = code
    HAML
  end

  # 駅施設の位置を記述するメソッド
  def render_place_name
    _root_infos_to_s = root_infos_to_s
    if _root_infos_to_s.present?
      h.render inline: <<-HAML , type: :haml , locals: { root_infos_to_s: _root_infos_to_s }
%div{ class: :place }<
  = root_infos_to_s
      HAML
    end
  end

  # 駅施設の詳細（利用可能日、利用可能時間など）を記述するメソッド
  def render_service_details
    _service_details = service_details
    if _service_details.present?
      h_locals = { service_details: _service_details }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :service_details }
  - service_details.each do | item |
    = item.decorate.render
      HAML
    end
  end

  def render_wheel_chair_info
    if escalator_available_to_wheel_chair?
      h.render inline: <<-HAML , type: :haml
%div{ class: :wheel_chair }<
  = "車いす対応"
      HAML
    end
  end

  def render_toilet_assistant
    _toilet_assistant_info_pattern = toilet_assistant_info_pattern
    if _toilet_assistant_info_pattern.present?
      _toilet_assistant_info_pattern.decorate.render
    end
  end

  def render_remark
    if remark.present?
      h.render inline: <<-HAML , type: :haml , locals: { remark_array: remark_to_a }
%div{ class: :remark }
  - remark_array.each do | str |
    %p<
      = str
      HAML
    end
  end

end