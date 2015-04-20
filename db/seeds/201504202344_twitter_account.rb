::RailwayLine.all.each do | item |
  # if item.twitter_widget_id.present? and item.twitter_account.present?
    # ::TwitterAccount.find_or_create_by( widget_id: item.twitter_widget_id ).update( name: item.twitter_account.to_s , operator_or_railway_type: "railway_line" , operator_or_railway_id: item.id )
  # end
  item.update( twitter_widget_id: nil , twitter_account: nil )
end

::Operator.all.each do | item |
  # if item.twitter_widget_id.present? and item.twitter_account.present?
    # ::TwitterAccount.find_or_create_by( widget_id: item.twitter_widget_id ).update( name: item.twitter_account.to_s , operator_or_railway_type: "operator" , operator_or_railway_id: item.id )
  # end
  item.update( twitter_widget_id: nil , twitter_account: nil )
end

nil