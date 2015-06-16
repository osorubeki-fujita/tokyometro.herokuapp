class OperatorDecorator < Draper::Decorator
  delegate_all

  include TwitterRenderer

  def twitter_title
    "Twitter #{ object.name_ja_normal_precise }【公式】"
  end

  def in_document
    ::OperatorDecorator::InDocument.new( self )
  end

end
