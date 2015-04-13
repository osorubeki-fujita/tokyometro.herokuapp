module TokyoMetro::Factory::Seed::Reference::TrainTypeInApi

  private

  def train_type_in_api_in_db( whole = nil , search_by: @train_type )
    if whole.present?
      whole.find_by_same_as( search_by )
    else
      ::TrainTypeInApi.find_by_same_as( search_by )
    end
  end

  def train_type_in_api_id( whole = nil , search_by: @train_type )
    _train_type_in_api_in_db = train_type_in_api_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by }\" does not exist in the database." if _train_type_in_api_in_db.nil?
    _train_type_in_api_in_db.id
  end

end