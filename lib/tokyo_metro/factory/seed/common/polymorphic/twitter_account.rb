module TokyoMetro::Factory::Seed::Common::Polymorphic::TwitterAccount

  private

  def seed_twitter_account
    if @info.twitter_widget_id.present? and @info.twitter_account.present?
      ::TwitterAccount.create( widget_id: @info.twitter_widget_id.to_s , name: @info.twitter_account , operator_or_railway_id: @id , operator_or_railway_type: twitter_polymorphic_type )
    end
  end

  def twitter_polymorphic_type
    db_class.to_s
  end

end