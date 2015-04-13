module TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::RailwayLine

  include ::TokyoMetro::Modules::Common::Info::Decision::RailwayLine

  private

  def on_the_railway_line_of?( *variables )
    super( *variables , @railway_line_in_db.same_as )
  end

  alias :is_on_the_railway_line_of? :on_the_railway_line_of?

end