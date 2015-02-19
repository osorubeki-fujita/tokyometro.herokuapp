class TokyoMetro::Api::StationTimetable::Info::Fundamental::Info::Separated::List < Array

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def seed( *args )
    super( *args , indent: 2 , not_on_the_top_layer: true , display_number: false , no_display: true )
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_fundamental_info_separeted_list
  end

end