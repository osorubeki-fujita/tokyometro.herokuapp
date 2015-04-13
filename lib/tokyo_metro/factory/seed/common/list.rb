class TokyoMetro::Factory::Seed::Common::List < TokyoMetro::Factory::Seed::Common::Group

  def initialize( array , *args )
    super( *args )
    set_array_to_seed( array )
  end

  def seed
    inspection do
      seed_main_infos
      seed_optional_infos
    end
    interruption
  end

  private

  def set_array_to_seed( array )
    @array_to_seed = array
  end

  def seed_main_infos
    # puts "=" * 64
    @array_to_seed.each.with_index(1) do | item , now_at |
      # puts "= " *32
      display_number( item , now_at )
      # puts "-" * 64
      # puts variables_send_to_item.length
      # puts variables_send_to_item.first
      # puts variables_send_to_item[1].class.name
      item.send( *variables_send_to_item )
      # puts "-" * 64
    end
  end

  def variables_send_to_item
    [ method_for_seeding_each_item ] + optional_variables
  end

  def optional_variables
    []
  end

  def method_for_seeding_each_item
    :seed
  end

end