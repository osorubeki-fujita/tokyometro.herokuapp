module TrainInformationHelper

  def train_information_title_of_each_station
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :train_information_title }
  = ::TrainInformationDecorator.render_common_title
  = station_name_main( station , station_code: true , all_station_codes: true )
= station.latest_passenger_survey.decorate.render_journeys_of_each_station
    HAML
  end

  def train_information_test( railway_line )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line }
= train_information_of_each_railway_line( railway_line , :on_time )
= train_information_of_each_railway_line( railway_line , :nearly_on_time )
= train_information_of_each_railway_line( railway_line , :delay )
= train_information_of_each_railway_line( railway_line , :suspended )
    HAML
  end

  def train_information_of_each_railway_line( railway_line , type )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line , type: type }
%div{ class: :train_information }
  = train_information_display_info_of_each_railway_line( railway_line )
  - case type
  - when :on_time
    = train_information_status_on_time
  - when :nearly_on_time
    = train_information_nearly_on_time
  - when :delay
    = train_information_delay
  - when :suspended
    = train_information_status_suspended
  - when :remark
    = remark
    HAML
  end

  def train_information_table( railway_lines )
    render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
%div{ id: :train_information }
  - railway_lines.each do | railway_line |
    - #
    HAML
  end

  private

  def train_information_display_info_of_each_railway_line( railway_line )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line }
= make_railway_line_matrix( railway_line , make_link_to_line: false , size: :small )
- # %div{ class: [ :line , railway_line.css_class_name ] }
- #   %div{ class: :image }
- #     = image_tag( "train_information/railway_line_code/#{ railway_line.name_code.downcase }.png" )
- #   %div{ class: :text }
- #     %p{ class: :text_ja }<
- #       = railway_line.name_ja
- #     %p{ class: :text_en }<
- #       = railway_line.name_en
  HAML
  end

  def train_information_additional_info( str = "" )
    content_tag( :div , str , class: :additional_info )
  end

end