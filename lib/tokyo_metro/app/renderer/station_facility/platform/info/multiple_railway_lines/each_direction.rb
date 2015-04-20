class TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::EachDirection < TokyoMetro::App::Renderer::StationFacility::Platform::Info::MetaClass::EachDirection

  include ::TokyoMetro::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines::Common

  def render_direction_info
    if @railway_direction.present?
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :info_of_railway_direction }
  %div{ class: :title_of_direction }
    - if info.of_special_direction?
      %h4{ class: :text_ja }<
        = info.render_special_direction_ja
      %h5{ class: :text_en }<
        = info.render_special_direction_en
    - else
      %h4{ class: :text_ja }<
        = info.railway_direction.station_info.decorate.render_name_ja( with_subname: true , suffix: "方面行きホーム" )
      %h5{ class: :text_en }<
        = info.railway_direction.station_info.decorate.render_name_en( with_subname: true , prefix: "Platform for " )
      HAML
    end
  end

  def of_special_direction?
    false
  end

  def render_special_direction_ja
    raise "Error: The method \'#{ __method__ }\' is not defined yet in this class."
  end

  def render_special_direction_en
    h.render inline: <<-HAML , type: :haml , locals: { special_direction_en: special_direction_en }
= special_direction_en
    HAML
  end

  def special_direction_en
    raise "Error: The method \'#{ __method__ }\' is not defined yet in this class."
  end

end