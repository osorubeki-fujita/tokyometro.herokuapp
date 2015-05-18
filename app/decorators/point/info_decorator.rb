class Point::InfoDecorator < Draper::Decorator

  delegate_all

  def render_in_station_facility_page
    h.render inline: <<-HAML , type: :haml , locals: { this: self , li_classes: li_classes }
%li{ class: li_classes , geo_lat: this.latitude , geo_long: this.longitude }
  = this.render_name_in_station_facility_page
  = this.render_close_info
    HAML
  end

  def render_name_in_station_facility_page
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- if this.has_elevator?
  %div{ class: [ :code , :elevator ] }
    = this.render_elevator_icon
    - if this.to_render_exit?
      %div{ class: [ :ev , :text_en ] }<
        = "EV"
    - else
      %div{ class: [ :code , this.li_classes_of_exit_with_elevator ].flatten }<
        = this.render_code
- else
  - if this.has_only_info_to_display_as_main_info?
    - if this.code_of_number_and_alphabet?
      - class_name = :text_en
    - else
      - class_name = :text_ja
    %div{ class: [ :code , class_name ].flatten }<
      = this.render_code
  - else
    = this.render_code
    HAML
  end

  def render_code
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- if this.to_render_exit?
  = this.render_exit

- elsif this.invalid?
  - raise "Error"

- elsif this.has_info_to_display_as_sub_info?
  %div{ class: :code }
    %div{ class: [ :main , :text_en ] }<
      = this.code
    = this.render_additional_info_in_station_facility_page

- else
  = this.code
    HAML
  end

  def render_additional_info_in_station_facility_page
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- if this.additional_info_ja.present? and this.additional_info_en.present?
  %div{ class: [ :additional_info , :text ] }
    %p{ class: :text_ja }<
      = this.additional_info_ja
    %p{ class: :text_en }<
      = this.additional_info_en
- elsif this.additional_info_ja.present?
  %div{ class: [ :additional_info , :text_ja ] }<
    = this.additional_info_ja
- elsif this.additional_info_en.present?
  - raise "Error: The variable \'additional_info_en\' is defined but \'additional_info_ja\' is not defined."
    HAML
  end

  def render_exit
    h.render inline: <<-HAML , type: :haml
%p{ class: :text_ja }<
  = "出口"
%p{ class: :text_en }<
  = "Exit"
    HAML
  end

  #--------

  def has_only_info_to_display_as_main_info?
    has_code? and !( has_additional_info? )
  end

  def has_info_to_display_as_sub_info?
    b = ( has_code? and has_additional_info? )
    if b and !( code_of_number_and_alphabet? )
      raise "Error"
    end
    b
  end

  # 「出口」と表示するか否かを判定するメソッド
  # @return [Boolean]
  def to_render_exit?
    !( has_code? ) and !( has_additional_info? )
  end

  #--------

  def li_classes_of_exit_with_elevator
    raise "Error: #{ code } in \"#{ object.station_facility.same_as}\"" unless has_elevator?
    if has_only_info_to_display_as_main_info?
      if code_of_number_and_alphabet?
        :text_en
      else
        :text_ja
      end
    else
      :text
    end

  end

  def render_elevator_icon
    h.image_tag( "barrier_free_facility/elevator_outside.svg" , class: :elevator_outside , title: "Elevator Outside" )
  end

  def render_close_info
    if closed?
      h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :close }<
  %div{ class: :icon }
    = ::TokyoMetro::App::Renderer::Icon.ban( request , 1 ).render
  %div{ class: :text }<
    %p{ class: :text_ja }<
      = "現在 閉鎖中"
    %p{ class: :text_en }<
      = "Now closed"
      HAML
    end
  end

  private

  def li_classes
    ary = [ :point , css_status_class_name ]
    if has_only_info_to_display_as_main_info? and code_of_number_and_alphabet?
      ary << :text_en
    end
    ary
  end

  def css_status_class_name
    if closed?
      :close
    else
      :open
    end
  end

  def type
    # code あり
    if has_code?
      # additional_info あり
      if has_additional_info?
        if has_elevator?
          :elevator_exit_with_code_and_additional_info
        else
          :exit_with_code_and_additional_info
        end
      # additional_info なし
      else
        if has_elevator?
          :elevator_exit_with_code
        else
          :exit_with_code
        end
      end
    # code なし
    else
      # additional_info あり
      if has_additional_info?
        if has_elevator?
          :elevator_exit_with_additional_info
        else
          :exit_with_additional_info
        end
      # additional_info なし
      else
        if has_elevator?
          :elevator_exit_without_any_info
        else
          :exit_without_any_info
        end
      end
    end
  end

end
