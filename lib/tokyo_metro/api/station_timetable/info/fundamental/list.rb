class TokyoMetro::Api::StationTimetable::Info::Fundamental::List < Array

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def seed( *args )
    super(
      *args ,
      indent: 1 ,
      not_on_the_top_layer: true ,
      display_number: false ,
      no_display: true
    )
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_fundamental_list
  end

  [ :stations , :railway_lines , :operators , :railway_directions ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        self.map( &:#{ method_name } ).flatten
      end
    DEF
  end

end