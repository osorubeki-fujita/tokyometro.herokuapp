class Station::InfoDecorator::InStationTimetable < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render_as_direction_info
    h.render inline: <<-HAML , type: :haml , locals: { direction_info: decorator.as_direction_info }
%div{ class: :text_ja }<
  = direction_info.name_ja
%div{ class: :text_en }<
  = direction_info.name_en
    HAML
  end

  def render_in_header
    h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ class: :additional_infos }
  = decorator.code.render_image( all: false )
  %div{ class: :station_name }<
    %div{ class: :text_ja }<
      = decorator.render_name_ja
    %div{ class: :text_en }<
      = decorator.name_en
    HAML
  end

  def render_name_ja
    if with_long_name_ja?
      render_name_ja_long
    else
      h.render inline: <<-HAML , type: :haml , locals: h_decorator
%div{ class: :destination }<
  = decorator.render_name_ja( with_subname: false )
      HAML
    end
  end

  def render_name_ja_long
    _splited_destination_name_ja = splited_destination_name_ja
    keys = _splited_destination_name_ja.keys
    h_locals = {
      normal_size_part: _splited_destination_name_ja[ :normal_size ] ,
      small_size_part: _splited_destination_name_ja[ :small_size ]
    }

    case keys.first
    when :normal_size
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :destination }<
  = normal_size_part
  - if small_size_part.present?
    %span{ class: :small }<>
      = small_size_part
      HAML

    when :small_size
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :destination }<
  %span{ class: :small }<>
    = small_size_part
  = normal_size_part
      HAML

    else
      raise "Error"
    end
  end

  private

  def with_long_name_ja?
    object.name_ja_actual.length >= 5
  end

  def splited_destination_name_ja
    destination_name_ja = object.name_ja_actual.delete_station_subname
    case destination_name_ja
    when "中野富士見町"
      { small_size: "中野" , normal_size: "富士見町" }
    when "東武動物公園"
      { normal_size: "東武" , small_size: "動物公園" }
    when "代々木上原"
      { small_size: "代々木" , normal_size: "上原" }
    when "明治神宮前"
      { normal_size: "明治" , small_size: "神宮前" }
    when "新宿三丁目"
      { normal_size: "新宿" , small_size: "三丁目" }
    when "石神井公園"
      { normal_size: "石神井" , small_size: "公園" }
    when "元町・中華街"
      { normal_size: "元町" , small_size: "・中華街" }
    else
      { normal_size: destination_name_ja , small_size: nil }
    end
  end

end
