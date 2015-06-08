module BarrierFreeFacilityTypeAndLocatedAreaDecorator

  def sub_title_ja
    object.name_ja
  end

  def sub_title_en
    object.name_en
  end

  def ul_class_name
    object.name_en.underscore.gsub( " " , "_" )
  end

end
