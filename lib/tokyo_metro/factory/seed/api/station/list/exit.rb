class TokyoMetro::Factory::Seed::Api::Station::List::Exit < TokyoMetro::Factory::Seed::Api::Station::List::Common

  private

  def method_for_seeding_each_item
    :seed_exits
  end

end