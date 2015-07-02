class BarrierFreeFacilityToiletAssistantPatternDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { toilet_assistant_info: self }
%ul{ class: [ :toilet_assistants  , :clearfix ] }<
  - ary = toilet_assistant_info.to_a
  - if ary.present?
    - ary.each do | assistant |
      %li{ class: :toilet_assistant }<
        = assistant
    HAML
  end

  def image_basename
    ary = ::Array.new
    if object.available_to_wheel_chair?
      ary << :wheel_chair
    end
    if object.has_facility_for_baby?
      ary << :baby
    end
    if object.has_facility_for_ostomate?
      ary << :ostomate
    end
    ary.select( &:present? ).join( "_" )
  end

end
