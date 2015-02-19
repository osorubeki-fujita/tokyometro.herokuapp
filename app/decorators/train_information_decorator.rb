class TrainInformationDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "この駅からの運行状況"
  end

  def self.common_title_en
    "Information of trains from stations"
  end

end