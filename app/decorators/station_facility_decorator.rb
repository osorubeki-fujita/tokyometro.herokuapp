class StationFacilityDecorator < Draper::Decorator
  delegate_all
  
  include CommonTitleRenderer
  
  def self.common_title_ja
    "駅のご案内"
  end
  
  def self.common_title_en
    "Information of station and its facilities"
  end

end