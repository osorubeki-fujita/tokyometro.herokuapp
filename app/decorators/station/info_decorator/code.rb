class Station::InfoDecorator::Code < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render_image_tag
    h.image_tag( filename , class: :station_code )
  end

  def render_image( all: false )
    if object.at_ayase? or object.at_nakano_sakaue?
      ::TokyoMetro::App::Renderer::StationCode::Normal.new( nil , object ).render
    elsif object.tokyo_metro?
      if all
        ::TokyoMetro::App::Renderer::StationCode::Normal.new( nil , object.station_infos_including_other_railway_line_infos ).render
      else
        ::TokyoMetro::App::Renderer::StationCode::Normal.new( nil , object ).render
      end

    else

      h.render inline: <<-HAML , type: :haml , locals: { obj: object }
%div{ class: :station_codes }<
  = "\[" + obj.station_code + "\]"
      HAML

    end
  end

  def all
    ary = object.station_infos_including_other_railway_line_infos.select_tokyo_metro.map( &:station_code )
    if object.at_ayase?
      ary.uniq
    else
      ary
    end
  end

  private

  def filename
    dirname = "provided_by_tokyo_metro/station_number"
    if /\Am(\d{2})\Z/ =~ station_code
      file_basename = "mm#{$1}"
    else
      if station_code.nil?
        raise "Error: " + same_as
      end
      file_basename = station_code.downcase
    end
    "#{dirname}/#{file_basename}.png"
  end

end
