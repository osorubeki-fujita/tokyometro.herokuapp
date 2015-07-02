class BarrierFreeFacilityTypeDecorator < Draper::Decorator
  delegate_all

  include SubTitleRenderer
  include BarrierFreeFacilityTypeAndLocatedAreaDecorator

  def image_basename
    case name_en
    when "Link for mobility scooter"
      :slope
    else
      name_en
    end
  end

end
