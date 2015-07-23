class Station::InfoDecorator::LinkToStationFacilityPage::Settings < TokyoMetro::Factory::Decorate::Settings

  def initialize( decorator , type_of_link_to_station , request = nil )
    super( decorator , request )
    @type_of_link_to_station = type_of_link_to_station
  end

  def railway_line_in_station_page
    unless link_to_station_page_for_each_railway_line?
      return nil
    end

    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and object.between_wakoshi_and_kotake_mukaihara?
      return "yurakucho_and_fukutoshin_line"

    elsif object.railway_line_info.is_branch_line?
      branch = object.railway_line_info
      main = branch.main_railway_line_info
      return main.decorate.page_name

    else
      return object.railway_line_info.decorate.page_name
    end
  end

  def anchor
    unless add_anchor?
      return nil
    end

    if object.between_wakoshi_and_kotake_mukaihara? and @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf
      "yurakucho_and_fukutoshin_line"
    else
      object.railway_line_info.decorate.page_name
    end
  end

  def link_to_station_page_for_each_railway_line?
    case @type_of_link_to_station
    when :must_link_to_railway_line_page , :must_link_to_railway_line_page_and_merge_yf
      true
    when :link_to_railway_line_page_if_containing_multiple_railway_lines
      object.has_another_railway_line_infos_of_tokyo_metro?
    when :link_to_railway_line_page_if_containing_multiple_railway_lines_and_merge_yf
      object.has_another_railway_line_infos_of_tokyo_metro? and !( object.between_wakoshi_and_kotake_mukaihara? )
    when nil
      false
    end
  end

  private

  def add_anchor?
    link_to_station_page_for_each_railway_line?
  end

end
