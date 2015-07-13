class Station::TrainTimeDecorator < Draper::Decorator
  delegate_all

  def departing_platform_info
    "#{ depart_from }番線発"
  end

  # def render_in_station_timetable( terminal_station_infos , train_type_infos , one_train_type_info , one_terminal_station_info , major_terminal_station_info_id )
  def render_in_station_timetable( rendering_settings )
    @rendering_settings = rendering_settings.with( object )

    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :station_train_time }
  = this.render_time_info
  = this.render_precise_infos
    HAML
  end

  # @!group 時刻

  def render_time_info
    raise unless departure_time_min.present? or arrival_time_min.present?
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :min }<
  - if this.departure_time_min.present?
    = this.departure_time_min
  - elsif this.arrival_time_min.present?
    %p{ class: :arrival_min }<
      = this.arrival_time_min
    %p{ class: :is_arrival }<
      = "到着"
    HAML
  end

  # @!group 詳細情報

  def render_precise_infos
    if @rendering_settings.to_render_precise_infos?
      h_locals = {
        this: self ,
        terminal_station_info_to_display: terminal_station_info_to_display ,
        train_type_info_to_display: train_type_info_to_display
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :precise }
  - if train_type_info_to_display.present?
    = train_type_info_to_display.decorate.render_in_station_timetable
  - if terminal_station_info_to_display.present?
    = terminal_station_info_to_display.decorate.render_name_ja_in_station_timetable
  - if this.has_additional_infos?
    = this.render_additional_infos_in_station_timetable
      HAML
    end
  end

  # @!group 補足情報

  def render_additional_infos_in_station_timetable
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :additional_infos }<
  = this.render_last_in_station_timetable
  = this.render_starting_info_at_this_station_in_station_timetable
  = this.render_departing_platform_info_in_station_timetable
  = this.render_starting_station_info_in_station_timetable
  = this.render_arrival_info_in_station_timetable
    HAML
  end

  def render_last_in_station_timetable
    if last_train?
      h.render inline: <<-HAML , type: :haml
%div{ class: :last }<>
  = "最終"
      HAML
    end
  end

  def render_starting_info_at_this_station_in_station_timetable
    if start_at_this_station?
      h.render inline: <<-HAML , type: :haml
%div{ class: :origin }<>
  = "当駅始発"
      HAML
    end
  end

  def render_departing_platform_info_in_station_timetable
    if has_departing_platform_info?
      h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :depart_from }<>
  = this.departing_platform_info
      HAML
    end
  end

  def render_starting_station_info_in_station_timetable
    if has_station_timetable_starting_station_info?
      station_timetable_starting_station_info.decorate.render
    end
  end

  def render_arrival_info_in_station_timetable
    if has_train_timetable_arrival_info?
      train_timetable_arrival_info.decorate.render
    end
  end

  # @!endgroup

  [ :train_type_info_to_display , :terminal_station_info_to_display ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        @rendering_settings.#{ method_name }
      end

      private :#{ method_name }
    DEF

  end

end
