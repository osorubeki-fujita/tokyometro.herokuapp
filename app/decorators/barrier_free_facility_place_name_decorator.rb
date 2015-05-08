class BarrierFreeFacilityPlaceNameDecorator < Draper::Decorator
  delegate_all

  def name_ja_for_display
    str = object.name_ja
    class << str
      include ::TokyoMetro::Factory::Convert::Patch::ForString::BarrierFreeFacility::PlaceName
    end
    str.process
  end

end