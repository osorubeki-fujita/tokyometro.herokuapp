class TrainOperation::InfoDecorator < Draper::Decorator

  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "列車運行情報"
  end

  def self.common_title_en
    "Information of train operation"
  end

end
