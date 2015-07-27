class Operator::AsTrainOwnerDecorator::InDocument < TokyoMetro::Factory::Decorate::SubDecorator::InDocument

  def render
    # operator.decorate.in_document.render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , info: object.info , number: object.id }
%li{ class: [ :document_info_box , :operator , info.css_class , :clearfix ] }
  = this.render_id_and_size_changing_buttons
  = this.render_main_domain
  = this.render_infos
    HAML
  end

  def render_main_domain
    object.info.decorate.in_document.render_main_domain
  end

  private

  def infos_to_render
    super().merge({
      "Infos from db columns of operator_info object" => infos_from_db_columns_of_operator_info_object ,
      "Infos from methods of operator_info object" => infos_from_methods_of_operator_info_object ,
      "Infos from methods of operator_info decorator" => infos_from_methods_of_operator_info_decorator
    })
  end

  def infos_from_db_columns_of_operator_info_object
    infors_from_db_columns_of( object.info )
  end

  def infos_from_methods_of_operator_info_object
    infos_from_methods_of( object.info , :name_ja_normal , :name_en_normal )
  end

  def infos_from_methods_of_operator_info_decorator
    infos_from_methods_of( object.info.decorate , :twitter_title )
  end

end
