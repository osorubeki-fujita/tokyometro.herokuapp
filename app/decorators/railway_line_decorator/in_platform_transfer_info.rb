class RailwayLineDecorator::InPlatformTransferInfo < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render
    h.render inline: <<-HAML , type: :haml , locals: { name_ja: name_ja , name_en: name_en }
%div{ class: :text }
  %p{ class: :text_ja }<
    = name_ja
  %p{ class: :text_en }<
    = name_en
    HAML
  end

  private

  def name_ja
    if object.tobu_sky_tree_isesaki_line?
      "東武線"
    elsif object.seibu_yurakucho_line?
      "西武線"
    else
      object.name_ja_with_operator_name
    end
  end

  def name_en
    if object.tobu_sky_tree_isesaki_line?
      "Tobu Skytree Line"
    elsif object.seibu_yurakucho_line?
      "Seibu Line"
    else
      object.name_en_with_operator_name
    end
  end

end
