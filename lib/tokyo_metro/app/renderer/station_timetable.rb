# 個別の時刻表（路線・方面・運行日別）を作成するためのクラス
class TokyoMetro::App::Renderer::StationTimetable < TokyoMetro::App::Renderer::MetaClass

  # Constructor
  # @param station_train_times_of_a_direction_and_an_operation_day [Array <TrainTime>] 各列車の情報（路線・方面・運行日別）のリスト
  # @param railway_line [RailwayLine] 路線のインスタンス
  # @param direction [RailwayDirection] 方面のインスタンス
  # @param operation_day [OperationDay] 運行日のインスタンス
  # @param station [Station] 駅のインスタンス（駅に複数の路線が乗り入れている場合は、代表する路線のインスタンス）
  def initialize( station_info , railway_line , railway_direction , operation_day , station_train_times )
    @station_info = station_info
    @railway_line = railway_line
    @railway_direction = railway_direction
    @operation_day = operation_day

    set_valid_station_info

    @station_train_times = ::TokyoMetro::App::Renderer::StationTimetable::StationTrainTimes.new( station_train_times )
  end

  attr_reader :station_train_times

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%table{ class: [ :station_timetable , operation_day.decorate.css_class_name ] }
  = this.render_header
  = this.station_train_times.render_body
    HAML
  end

  def render_header
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%thead{ class: railway_line.css_class_name }
  %tr
    %td{ colspan: 2 , class: :top_header }
      = railway_line.decorate.render_in_station_timetable_header
      %div{ class: :main }
        = operation_day.decorate.render_in_station_timetable_header
        = railway_direction.decorate.render_in_station_timetable_header
        - if station_info.present?
          = station_info.decorate.render_in_station_timetable_header
  = station_train_times.render_message_in_header
    HAML
  end

  private

    # @note
    #   station （駅のインスタンス）に保持されている路線の情報が railway_line （路線のインスタンス）と異なる場合は、
    #   railway_line を優先し、station と同名の駅に乗り入れている路線の中から railway_line と矛盾しない駅のインスタンスを取得する。
  def set_valid_station_info
    unless @station_info.railway_line_id == @railway_line.id
      @station_info = @station_info.station_infos_including_other_railway_lines.find_by( railway_line_id: @railway_line.id )
    end
  end

  def h_locals
    super.merge({
      this: self ,
      station_info: @station_info ,
      railway_line: @railway_line ,
      railway_direction: @railway_direction ,
      operation_day: @operation_day ,
      station_train_times: @station_train_times
    })
  end

end