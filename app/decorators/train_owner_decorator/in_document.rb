class TrainOwnerDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    # operator.decorate.in_document.render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , operator_info: object.operator_info , number: object.id }
%li{ class: [ :document_info_box , :operator , operator_info.css_class , :clearfix ] }
  = this.render_id_and_size_changing_buttons
  = this.render_main_domain
  = this.render_button_domain
  = this.render_infos
    HAML
  end

  def render_main_domain
    object.operator_info.decorate.in_document.render_main_domain
  end

  private

  def infos_to_render
    super().merge({
      "Infos from Db columns of operator_info object" => infos_from_db_columns_of_operator_info_object ,
      "Infos from methods of operator_info object" => infos_from_methods_of_operator_info_object ,
      "Infos from methods of operator_info decorator" => infos_from_methods_of_operator_info_decorator
    })
  end

  def infos_from_db_columns_of_operator_info_object
    infors_from_db_columns_of( object.operator_info )
  end

  def infos_from_methods_of_operator_info_object
    infos_from_methods_of( object.operator_info , :name_ja_normal , :name_en_normal )
  end

  def infos_from_methods_of_operator_info_decorator
    infos_from_methods_of( object.operator_info.decorate , :twitter_title )
  end

end
