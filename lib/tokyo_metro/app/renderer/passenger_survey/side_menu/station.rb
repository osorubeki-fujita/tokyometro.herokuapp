class TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::Station < TokyoMetro::App::Renderer::PassengerSurvey::SideMenu::MetaClass

  def initialize( request , station_info )
    super( request )
    @station_infos = station_info.railway_lines_of_tokyo_metro

    if station_info.at_kita_ayase? or station_info.between_honancho_and_nakano_shimbashi?
      @prior_railway_line_ids = station_info.railway_line.main_railway_line.id
    else
      @prior_railway_line_ids = @station_infos.pluck( :railway_line_id )
    end
  end

  private

  def railway_lines_prior
    @all_railway_lines.where( id: @prior_railway_line_ids )
  end

  def railway_lines_not_prior
    @all_railway_lines.where.not( id: @prior_railway_line_ids )
  end

  def proc_for_links_to_railway_line_pages
    ::Proc.new {
      h_locals_for_this_proc = {
        railway_lines_prior: railway_lines_prior ,
        railway_lines_not_prior: railway_lines_not_prior ,
        years: @years
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals_for_this_proc
%ul{ id: :links_to_railway_line_pages_of_this_station , class: :links }
  %li{ class: [ :title , :in_station_page ] }<
    != "この駅に乗り入れている路線の乗降客数"
    %span{ class: :small }<
      = "（年度別）"
  - railway_lines_prior.each do | railway_line |
    = railway_line.decorate.render_link_to_railway_line_page_of_passenger_survey( years , additional_class_of_li: :this_station )
%ul{ id: :links_to_railway_line_pages , class: :links }
  %li{ class: [ :title , :in_station_page ] }<
    != "その他の路線の乗降客数"
    %span{ class: :small }<
      = "（年度別）"
  - railway_lines_not_prior.each do | railway_line |
    = railway_line.decorate.render_link_to_railway_line_page_of_passenger_survey( years )
      HAML
    }
  end

end