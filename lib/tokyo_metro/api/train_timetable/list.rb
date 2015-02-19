# 列車別の時刻表の情報の配列
class TokyoMetro::Api::TrainTimetable::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable  
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List
  include ::TokyoMetro::Modules::Api::List::Selection::RailwayLines

  def seed
    super(
      ::Operator.all ,
      ::RailwayLine.all ,
      ::Station.all ,
      ::RailwayDirection.all ,
      ::TrainOwner.all ,
      display_number: true
    )
  end

  [ :terminal_station , :starting_station ].each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name.to_s.pluralize }
        self.map( &:#{ method_base_name } ).sort.uniq
      end
    DEF
  end

  def stations
    self.map( &:stations ).flatten.sort.uniq
  end

  private

  def seed_arrival_times_of_romance_car
    __seed__(
      factory_name: :factory_for_seeding_arrival_times_of_romance_car ,
      method_name: __method__ ,
      indent: 1 ,
      not_on_the_top_layer: true ,
      display_number: false
    )
  end

  def seed_arrival_times_of_last_station_in_tokyo_metro
    __seed__(
      factory_name: :factory_for_seeding_arrival_times_of_last_station_in_tokyo_metro ,
      method_name: __method__ ,
      indent: 1 ,
      not_on_the_top_layer: true ,
      display_number: false
    )
  end

end