class BarrierFreeFacilityLocatedAreaDecorator < Draper::Decorator
  delegate_all

  include SubTitleRenderer
  include BarrierFreeFacilityTypeAndLocatedAreaDecorator

end