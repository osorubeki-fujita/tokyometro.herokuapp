class RenamePassengerJourneyInPassengerSurvey < ActiveRecord::Migration
  def change
    rename_column :passenger_surveys , :passenger_journey , :passenger_journeys
  end
end
