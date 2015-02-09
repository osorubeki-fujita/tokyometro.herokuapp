class TokyoMetro::Factories::Seed::Api::Station::List::Exit < TokyoMetro::Factories::Seed::Api::Station::List::Common

  private

  def method_for_seeding_each_item
    :seed_exits
  end

end