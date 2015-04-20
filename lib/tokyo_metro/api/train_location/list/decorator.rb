class TokyoMetro::Api::TrainLocation::List::Decorator < TokyoMetro::Api::MetaClass::RealTime::Info::Decorator

  def initialize( request , obj , railway_line )
    super( request , obj )
    @railway_line = railway_line
  end

  attr_reader :railway_line

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- this.object.group_by_railway_direction.each do | railway_direction_in_api_same_as , train_locations |
  - railway_line = this.railway_line
  - railway_direction = ::RailwayDirection.find_by( railway_line_id: railway_line.id , in_api_same_as: railway_direction_in_api_same_as )
  - if railway_direction.blank?
    - raise "\[Error\] railway_line: " + railway_line.same_as + " / railway_direction: " + railway_direction_in_api_same_as
  = railway_direction.decorate.render_title_in_train_location
  - train_locations.each do | train_location |
    = train_location.decorate( request , this.railway_line ).render
    HAML
  end

end