module TokyoMetro::Factory::Seed::Reference::TrainOwner

  private

  def train_owner_in_db( whole = nil , search_by: @info.train_owner )
    if whole.present?
      whole.find_by_same_as( search_by )
    else
      ::TrainOwner.find_by_same_as( search_by )
    end
  end

  def train_owner_id( whole = nil , search_by: @info.train_owner )
    _train_owner_in_db = train_owner_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by }\" does not exist in the database." if _train_owner_in_db.nil?
    _train_owner_in_db.id
  end

end