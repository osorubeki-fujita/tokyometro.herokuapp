class TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::MetaClass < TokyoMetro::App::Renderer::MetaClass

  def initialize( request )
    super( request )
    @all_railway_lines = ::RailwayLine.tokyo_metro( including_branch_line: false )
    @years = ::PassengerSurvey.all.pluck( :survey_year ).uniq.sort
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ class: :links , id: :links_to_passenger_survey_pages }
  = proc_for_links_to_railway_line_pages.call
  = proc_for_links_to_year_pages.call
  = proc_for_links_to_station_pages.call
    HAML
  end

  private

  def h_locals
    super.merge({
      proc_for_links_to_railway_line_pages: proc_for_links_to_railway_line_pages ,
      proc_for_links_to_year_pages: proc_for_links_to_year_pages ,
      proc_for_links_to_station_pages: proc_for_links_to_station_pages
    })
  end

  def proc_for_links_to_railway_line_pages
    ::Proc.new {
      h.render inline: <<-HAML , type: :haml , locals: { all_railway_lines: @all_railway_lines , survey_years: @years }
%ul{ id: :links_to_railway_line_pages , class: :links }
  %li{ class: [ :title , :in_station_page ] }<
    != "各路線 各駅の乗降客数"
    %span{ class: :small }<
      = "（年度別）"
  - all_railway_lines.each do | railway_line |
    = railway_line.decorate.render_link_to_railway_line_page_of_passenger_survey( survey_years )
      HAML
    }
  end

  def proc_for_links_to_year_pages
    ::Proc.new {
      h.render inline: <<-HAML , type: :haml , locals: { request: request , survey_years: @years }
%ul{ id: :links_to_year_pages , class: :links }
  %li{ class: [ :title , :to_year_pages ] }<
    != "全路線 全駅の乗降客数"
    %span{ class: :small }<
      = "（年度別）"
  %ul{ class: :operator }
    %li{ class: [ :tokyo_metro , :small ] }
      = ::PassengerSurveyDecorator.link_to_year_page( nil )
      %div{ class: :link_to_operator_page }
        %div{ class: :icon }
          = ::TokyoMetro::App::Renderer::Icon.tokyo_metro( request ).render
        %div{ class: :text }
          %p{ class: :text_ja }<
            = "東京メトロ 全駅"
          %p{ class: :text_en }<
            = "All stations of Tokyo Metro"
      - survey_years.sort.reverse.each do | survey_year |
        = ::PassengerSurveyDecorator.render_link_to_year_page( survey_year )
      HAML
    }
  end

  def proc_for_links_to_station_pages
    ::Proc.new {
      h.render inline: <<-HAML , type: :haml
%ul{ class: :links , id: :links_to_station_pages }
  %li{ class: [ :title , :passenger_info_header ] }<
    != "各駅の乗降客数"
    %span{ class: :small }<
      = "（年度別）"
      HAML
    }
  end

end