class StationFacilityPlatformInfoDecorator < Draper::Decorator
  delegate_all

  extend SubTopTitleRenderer
  
  def self.sub_top_title_ja
    "乗車・降車位置のご案内"
  end
  
  def self.sub_top_title_en
    "Information of transfer, barrier free facilities, surrounding areas on the platforms"
  end

end
