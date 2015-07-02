class BarrierFreeFacilityEscalatorDirectionDecorator < Draper::Decorator
  delegate_all

  ICON_UP = :arrow_up
  ICON_DOWN = :arrow_down
  # ICON_BOTH = :arrows_v

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , icon_names: icon_names }
%li{ class: :escalator_direction }<
  %div{ class: :direction_icons }
    %div{ class: [ :direction_icon , :up ] }<
      - if icon_names.include?( :arrow_up )
        = ::TokyoMetro::App::Renderer::Icon.arrow_up( nil , 1 ).render
    %div{ class: [ :direction_icon , :down ] }<
      - if icon_names.include?( :arrow_down )
        = ::TokyoMetro::App::Renderer::Icon.arrow_down( nil , 1 ).render
  %div{ class: :text }<
    = this.to_s
    HAML
  end

  private

  def icon_names
    if object.only_up?
      [ ICON_UP ]
    elsif object.only_down?
      [ ICON_DOWN ]
    else
      [ ICON_UP , ICON_DOWN ]
    end
  end

end
