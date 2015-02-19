class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::List < Array

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime::Db
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def list
    self.map( &:same_as )
  end

  def trains_in_api
    self.map( &:in_api )
  end

  undef :seed

  def seed( *args )
    __seed__(
      *args ,
      factory_name: :factory_for_seeding_this_class ,
      class_name: self.class ,
      method_name: __method__  ,
      indent: 0 ,
      not_on_the_top_layer: true ,
      display_number: true
    )
  end

end