class FareDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer

  def self.common_title_ja
    "運賃のご案内"
  end

  def self.common_title_en
    "Fares"
  end

end