class TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::StationInfos::GroupInfo < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , normal_fare_group_id , station_info , normal_fare_groups )
    super( request )

    @normal_fare_group = set_normal_fare_group( normal_fare_group_id , normal_fare_groups )
    @station_infos = [ station_info ]
  end

  def add( station_info )
    @station_infos << station_info
  end

  def render
    if @normal_fare_group.present?
      render_when_normal_fare_group_is_present
    else
      render_when_normal_fare_group_is_not_present
    end
  end

  private

  def h_locals
    super.merge({
      normal_fare_group: @normal_fare_group ,
      station_infos: @station_infos ,
      number_of_station_infos: @station_infos.length
    })
  end

  def set_normal_fare_group( normal_fare_group_id , normal_fare_groups )
    if normal_fare_group_id == 0
      nil
    else
      normal_fare_groups.find( normal_fare_group_id )
    end
  end

  # normal_fare_group_id が定義されている場合
  def render_when_normal_fare_group_is_present
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- normal_fare_decorated = normal_fare_group.decorate
- station_infos.each.with_index(1) do | station_info , i |
  - case i
  - when number_of_station_infos
    %tr{ class: :last }<
      = station_info.decorate.render_in_fare_table
      - if i == 1
        = normal_fare_decorated.render_columns( number_of_station_infos )
  - else
    %tr<
      = station_info.decorate.render_in_fare_table
      - if i == 1
        = normal_fare_decorated.render_columns( number_of_station_infos )
    HAML
  end

  def render_when_normal_fare_group_is_not_present
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- # normal_fare_group_id が定義されている場合
- # （運賃が設定されていない場合）
- station_infos.each do | station_info , i |
  %tr<
    = station_info.decorate.render_in_fare_table
    %td{ colspan: number_of_station_infos_in_this_group , colspan: 4 , class: :no_fare }<>
      = " "
    HAML
  end

end