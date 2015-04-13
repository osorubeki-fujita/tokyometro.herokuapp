class TokyoMetro::Factory::Seed::Static::Station::InEachRailwayLine < TokyoMetro::Factory::Seed::Static::MetaClass::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::Station
  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine

  include ::TokyoMetro::Factory::Seed::Static::Station::OptionalVariables

  private

  def seed_main_infos
    _railway_line_id = railway_line_id

    @array_to_seed.each.with_index(1) do | item , now_at |
      display_number( item , now_at )
      item.seed( _railway_line_id )
    end
  end

  [ :railway_line_in_db , :railway_line_id ].each do | method_name |
    eval <<-DEF
      def #{method_name}( whole = nil , search_by: @railway_line_id )
        super( whole , search_by: search_by )
      end
    DEF
  end

end