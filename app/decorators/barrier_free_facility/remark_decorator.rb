class BarrierFreeFacility::RemarkDecorator < Draper::Decorator
  delegate_all

  def render
    h.render inline: <<-HAML , type: :haml , locals: { ja_to_a: ja_to_a }
%div{ class: :remark }
  - ja_to_a.each do | str |
    %p<
      = str
    HAML
  end

  def in_tooltip
    ja_to_a.join( ::BarrierFreeFacility::InfoDecorator::IN_DATA_FOR_TOOLTIP_JOINED_BY )
  end

  private

  def ja_to_a
    object.ja.split( /\n/ )
  end

end
