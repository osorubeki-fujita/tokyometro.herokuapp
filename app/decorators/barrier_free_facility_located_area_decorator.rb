class BarrierFreeFacilityLocatedAreaDecorator < Draper::Decorator
  delegate_all

  include SubTitleRenderer
  include BarrierFreeFacilityTypeAndLocatedAreaDecorator

  private

  def class_of_sub_title
    :title_of_each_area
  end

end
