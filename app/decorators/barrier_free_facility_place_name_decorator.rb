class BarrierFreeFacilityPlaceNameDecorator < Draper::Decorator
  delegate_all

  def name_ja_for_display
    object.name_ja.zen_num_to_han.convert_comma_between_number_to_dot.gsub( "東部スカイツリーライン" , "東武スカイツリーライン" )
  end

end