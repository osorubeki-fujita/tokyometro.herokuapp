module TokyoMetro::Factory::Seed::Reference::NormalFareGroup

  private

  def normal_fare_group_in_db( whole = nil , search_by: @info.normal_fare )
    h = {
      ticket_fare: search_by.ticket_fare #,
      # child_ticket_fare: search_by.child_ticket_fare ,
      # ic_card_fare: search_by.ic_card_fare ,
      # child_ic_card_fare: search_by.child_ic_card_fare
    }
    if whole.present?
      whole.find_by(h)
    else
      ::NormalFareGroup.find_by(h)
    end
  end

  def normal_fare_group_id( whole = nil , search_by: @info.normal_fare )
    _normal_fare_group_in_db= normal_fare_group_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by.same_as }\" does not exist in the database." if _normal_fare_group_in_db.nil?
    _normal_fare_group_in_db.id
  end

end