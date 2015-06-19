class TrainOwnerDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    # operator.decorate.in_document.render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , operator: object.operator , number: object.id }
%li{ class: [ :document_info_box , :operator , operator.css_class_name , :clearfix ] }
  %div{ class: [ :number , :text_en ] }<
    = number
  = this.render_main_domain
  = this.render_button_domain
  = this.render_infos
    HAML
  end

  def render_main_domain
    object.operator.decorate.in_document.render_main_domain
  end

  private

  def infos_to_render
    super().merge({
      "Infos from Db columns of operator object" => infos_from_db_columns_of_operator_object ,
      "Infos from methods of operator object" => infos_from_methods_of_operator_object ,
      "Infos from methods of operator decorator" => infos_from_methods_of_operator_decorator
    })
  end

  def infos_from_db_columns_of_operator_object
    infors_from_db_columns_of( object.operator )
  end

  def infos_from_methods_of_operator_object
    infos_from_methods_of( object.operator , :name_ja_normal , :name_en_normal )
  end

  def infos_from_methods_of_operator_decorator
    infos_from_methods_of( object.operator.decorate , :twitter_title )
  end

end
