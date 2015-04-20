class TokyoMetro::App::Renderer::StationTimetable::StationTrainTimes < TokyoMetro::App::Renderer::MetaClass

  def initialize( station_train_times )
    @grouped_by_hour = station_train_times.group_by( &:hour_in_station_timetable )

    @terminal_station_infos = ::Station::Info.where( id: terminal_station_info_ids )
    @train_type_infos = ::TrainType.includes( :train_type_in_api ).where( id: train_type_info_ids )
    @car_compositions = ids_in_station_train_times( :car_composition ).select( &:present? )
    @major_terminal_station_info_id = get_major_terminal_station_info_id
  end

  attr_reader :grouped_by_hour
  attr_reader :terminal_station_infos
  attr_reader :train_type_infos
  attr_reader :car_compositions
  attr_reader :major_terminal_station_info_id

  def has_one_terminal_station_info?
    @terminal_station_infos.length == 1
  end

  def has_one_train_type_info?
    @train_type_infos.map( &:train_type_in_api ).map( &:id ).uniq.length == 1
  end

  def hours
    midnight_hours = [ 0 , 1 , 2 ]
    a = @grouped_by_hour.keys.sort

    midnight_hours.each do | midnight_hour |
      if a.include?( midnight_hour )
        a = a - [ midnight_hour ]
        a = a + [ midnight_hour ]
      end
    end

    a
  end

  def render_body
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- one_terminal_station_info = this.has_one_terminal_station_info?
- one_train_type_info = this.has_one_train_type_info?
%tbody
  - this.hours.each do |h|
    - station_train_times_in_an_hour = this.grouped_by_hour[h].sort_by( &:min_in_station_timetable )
    %tr{ class: :hour_row }
      %td{ class: :hour }<
        = h
      %td{ class: [ :station_train_times , cycle( :odd , :even ) ] }
        - station_train_times_in_an_hour.each do | station_train_time |
          = station_train_time.decorate.render_in_station_timetable( this.terminal_station_infos , this.train_type_infos , one_train_type_info , one_terminal_station_info , this.major_terminal_station_info_id )
    HAML
  end

  def render_message_in_header
    h.render inline: <<-HAML , type: :haml , locals: { ja: message_in_header_ja , en: message_in_header_en }
%tr
  %td{ colspan: 2 , class: :train_type_and_terminal_station_infos }<
    %div{ class: :text_ja }<
      = ja
    %div{ class: :text_en }<
      = en
    HAML
  end

  private

  def ary
    @grouped_by_hour.values.flatten
  end

  def ids_in_station_train_times( method_name )
    ary.map { | station_train_time | station_train_time.send( method_name ) }.uniq
  end

  def terminal_station_info_ids
    ids_in_station_train_times( :terminal_station_info_id )
  end

  def train_type_info_ids
    ids_in_station_train_times( :train_type_id )
  end

  def get_major_terminal_station_info_id
    nishi_takashimadaira_id = ::Station::Info.find_by( same_as: "odpt.Station:Toei.Mita.NishiTakashimadaira" ).id
    terminal_station_info_ids.delete_if { |n| n == nishi_takashimadaira_id }.max { | terminal_station_info_id_1 , terminal_station_info_id_2 |
      number_of_trains_for( terminal_station_info_id_1 ) <=> number_of_trains_for( terminal_station_info_id_2 )
    }
  end

  def number_of_trains_for( station_info_id )
    ary.count { | station_train_time | station_train_time.terminal_station_info_id == station_info_id }
  end

  def h_locals
    super.merge({
      this: self
    })
  end
  
  def message_in_header_ja
    str = ::String.new
    one_terminal_station_info = has_one_terminal_station_info?
    one_train_type_info = has_one_train_type_info?
    if one_terminal_station_info or one_train_type_info
      str << "列車はすべて "
      if one_train_type_info
        str << @train_type_infos.first.train_type_in_api.name_ja
        str << " "
      end
      if one_terminal_station_info
        str << @terminal_station_infos.first.name_ja
        str << " 行き "
      end
      str << "です。"
      unless one_terminal_station_info
        str << "なお、"
      end
    end

    unless one_terminal_station_info
      str << "行先の記載がない列車はすべて "
      str << major_terminal_station_info.name_ja
      str << " 行きです。"
    end
    str
  end
  
  def message_in_header_en
    str = ::String.new
    one_terminal_station_info = has_one_terminal_station_info?
    one_train_type_info = has_one_train_type_info?
    if one_terminal_station_info or one_train_type_info
      str << "All trains are"
      if one_train_type_info
        str << " "
        str << @train_type_infos.first.train_type_in_api.name_en
      end
      if one_terminal_station_info
        str << " "
        str << "bound for "
        str << @terminal_station_infos.first.name_en
      end
      str << "."
      unless one_terminal_station_info
        str << " "
      end
    end

    unless one_terminal_station_info
      str << "All trains with no description of destination are bound for "
      str << major_terminal_station_info.name_en
      str << "."
    end
    str
  end

  def major_terminal_station_info
    @terminal_station_infos.find_by( id: @major_terminal_station_info_id )
  end

end