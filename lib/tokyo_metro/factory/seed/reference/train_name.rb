module TokyoMetro::Factory::Seed::Reference::TrainName

  private

  def train_name_in_db( whole = nil , search_by: @info.train_name )
    if search_by.present?
      if whole.present?
        whole.find_by_same_as( search_by )
      else
        ::TrainType.find_by_same_as( search_by )
      end
    else
      nil
    end
  end

  def train_name_id( whole = nil , search_by: @info.train_name )
    _train_name_in_db = train_name_in_db( whole , search_by: search_by )
    if _train_name_in_db.present?
      _train_name_in_db.id
    else
      nil
    end
  end

end