class BarrierFreeFacility::InfoDecorator < Draper::Decorator

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

  def self.inspect_image_filenames
    ary = ::Array.new
    ::BarrierFreeFacility::Info.all.each do | item |
      filename = item.decorate.image_filename
      if filename.blank?
        raise "Error: ● #{ item.same_as }"
      else
        ary << filename
        if /stairlift/ =~ filename
          puts "○ " + item.same_as
        elsif /slope/ =~ filename
          puts "△ " + item.same_as
        end
      end
    end
    puts ""
    puts ary.uniq.sort
  end

  # 個々の駅施設の記号を返すメソッド
  # @return [Hash]
  def id_and_code_hash
    regexp = /\Aodpt\.StationFacility\:TokyoMetro\.(\w+)\.(?:\w+)\.(Inside|Outside)\.(\w+)/
    if regexp =~ same_as.to_s
      railway_line_name = $1
      railway_line_code_letter = ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.#{ railway_line_name }" ).name_code

      place = $2
      category = $3
      if /\A\.(\d+)\Z/ =~ same_as.to_s.gsub( regexp , "" )
        number = $1
      else
        number = nil
      end
    else
      raise "Error: #{ same_as }"
    end

    facility_id = [ railway_line_code_letter.downcase , place.downcase , category.downcase , number ].select( &:present? ).map( &:to_s ).join( "_" )
    facility_code = [ railway_line_code_letter , number ].map( &:to_s ).join
    platform = [ railway_line_code_letter , place , category , number ].select( &:present? ).map( &:to_s ).join( "." )
    { id: facility_id , code: facility_code , platform: platform }
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
    str = remark
    class << str
      include ::TokyoMetro::Factory::Convert::Patch::ForString::BarrierFreeFacility::Info::Remark
    end
    str.process.split( /\n/ )
  end

  def image_filename
    ary = ::Array.new
    ary << type.decorate.image_basename
    unless service_details.present? and service_details.length > 1
      if escalator?
        set_wheel_chair_info_to( ary )
        directions = object.escalator_directions
        raise "Error" if directions.length > 1
        if directions.present?
          ary << directions.first.pattern.attribute
        else
          puts "※ " + object.same_as
        end
      elsif toilet?
        pattern = barrier_free_facility_toilet_assistant_pattern
        ary << pattern.decorate.image_basename
      end
    end
    ary << located_area.name_en
    image_file_basename = ary.select( &:present? ).map { | item | item.to_s.underscore.downcase }.join( "_" )
    "barrier_free_facilities/#{ image_file_basename }.svg"
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%li{ class: [ :facility , :clearfix ] }
  %div{ class: [ :image_and_number , :clearfix ] }
    = image_tag( this.image_filename , class: :barrier_free_facility , title: this.title_added_to_image )
    = this.render_place_name_number
  %div{ class: :info }
    = this.render_place_name
    = this.render_service_details
    - # 車いす対応か否かの情報
    = this.render_wheel_chair_info
    - # トイレ設備
    = this.render_toilet_assistant
    - # 特記事項
    = this.render_remark
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
%p{ class: :place }<
  = root_infos_to_s
      HAML
    end
  end

  # 駅施設の詳細（利用可能日、利用可能時間など）を記述するメソッド
  def render_service_details
    _service_details = service_details
    if _service_details.present?
      h.render inline: <<-HAML , type: :haml , locals: { service_details: _service_details }
%ul{ class: :service_details }
  - service_details.each do | item |
    = item.decorate.render
      HAML
    end
  end

  def render_wheel_chair_info
    if escalator_available_to_wheel_chair?
      h.render inline: <<-HAML , type: :haml
%span{ class: :wheel_chair }<
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

  def render_in_platform_info
    hs = id_and_code_hash
    if image_filename.present?
      options = tooltip_options_in_platform_info.merge({ class: :barrier_free_facility })
      h.link_to(
        h.image_tag( image_filename , options ) ,
        h.url_for( anchor: hs[ :id ] )
      )
    else
      raise
    end
  end

  def title_added_to_image
    "#{ type.name_en } - #{ id_and_code_hash[ :platform ] }"
  end

  private

  def set_wheel_chair_info_to( ary )
    if available_to_wheel_chair?
      ary << :wheel_chair
    end
  end

  def available_to_wheel_chair?
    object.available_to_wheel_chair?
  end

  IN_DATA_FOR_TOOLTIP_JOINED_BY = "／"

  def tooltip_options_in_platform_info
    h = ::Hash.new
    h[ "data-place" ] = root_infos_to_s
    if service_details.present?
      h[ "data-service_details" ] = service_details.map( &:decorate ).map( &:in_data_class_for_tooltip ).join( IN_DATA_FOR_TOOLTIP_JOINED_BY )
    end
    if escalator_available_to_wheel_chair?
      h[ "data-wheelchair" ] = "車いす対応"
    end
    if toilet_assistant_info_pattern.present?
      h[ "data-toilet_assistant" ] = toilet_assistant_info_pattern.to_s
    end
    if remark.present?
      h[ "data-remark" ] = remark_to_a.join( IN_DATA_FOR_TOOLTIP_JOINED_BY )
    end

    h
  end

end
