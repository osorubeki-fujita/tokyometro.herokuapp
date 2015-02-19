class BarrierFreeFacilityTypeDecorator < Draper::Decorator
  delegate_all

  include SubTitleRenderer
  include BarrierFreeFacilityTypeAndLocatedAreaDecorator

end