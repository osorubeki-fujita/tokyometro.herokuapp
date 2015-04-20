class TokyoMetro::Api::TrainLocation::Info::Decorator < TokyoMetro::Api::MetaClass::RealTime::Info::Decorator

  def initialize( request , obj , railway_line )
    super( request , obj )
    @railway_line = railway_line
  end

  attr_reader :railway_line

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- train_type_in_api = ::TrainTypeInApi.find_by( same_as: this.object.train_type )
- starting_station = ::Station::Info.find_by( same_as: this.object.starting_station )
- terminal_station = ::Station::Info.find_by( same_as: this.object.terminal_station )
%div{ class: :train_location , id: this.object.train_number.downcase }
  %div{ class: :train_fundamental_infos }
    = this.railway_line.decorate.render_matrix( make_link_to_railway_line: false , size: :small )
    %div{ class: :train_infos }
      = train_type_in_api.decorate.render_in_train_location
      = terminal_station.decorate.train_location.render_as_terminal_station
  %div{ class: :sub_infos }
    = starting_station.decorate.train_location.render_as_starting_station
    = this.render_train_number
    = this.render_delay
  = this.render_current_position
    HAML
  end

  def render_train_number
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :train_number }
  %div{ class: :title_of_train_number }
    %p{ class: :text_ja }<
      = "列車番号"
    %p{ class: :text_en }<
      = "Train number "
  %div{ class: [ :train_number_text , :text_en ] }<
    = this.object.train_number
    HAML
  end

  def render_current_position
    stations = [ :from_station , :to_station ].map { | attr_name |
      object.send( attr_name )
    }.select( &:present? ).map { | station_info_same_as |
      case station_info_same_as
      when "odpt.Station:TokyoMetro.Chiyoda.KitaAyase"
        "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase"
      else
        station_info_same_as
      end
    }.map { | station_info_same_as |
      ::Station::Info.find_by( same_as: station_info_same_as )
    }

    h.render inline: <<-HAML , type: :haml , locals: { request: request , stations: stations }
%div{ class: :current_position }
  %div{ class: :title_of_current_position }
    %p{ class: :text_ja }<
      = "現在位置"
    %p{ class: :text_en }<
      = "Now at"
  %div{ class: :station_infos }<
    - stations.each.with_index(1) do | station , i |
      = station.decorate.train_location.render_name
      - unless i == stations.length
        %div{ class: :arrow }
          = ::TokyoMetro::App::Renderer::Icon.caret_right( request , 2 ).render
    HAML
  end

  def render_delay
    object.delay_instance.decorate( request ).render_in_location_of_each_train
  end

end