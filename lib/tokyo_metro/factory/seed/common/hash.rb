class TokyoMetro::Factory::Seed::Common::Hash < TokyoMetro::Factory::Seed::Common::Group

  def initialize( h , *args )
    super( *args )
    set_array_to_seed(h)
  end

  def seed
    inspection do
      seed_main_infos
      seed_optional_infos
    end
    interruption
  end

  private

  def seed_main_infos
    @array_to_seed.each.with_index(1) do | item , now_at |
      display_number( item , now_at )
      item.seed
    end
  end

  def set_array_to_seed(h)
    @array_to_seed = h.values
  end

end