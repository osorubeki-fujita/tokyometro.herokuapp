class TrainLocationDecorator < Draper::Decorator

  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
  "現在運行中の列車位置情報"
  end

  def self.common_title_en
    "Current positions of trains operated now"
  end

end
