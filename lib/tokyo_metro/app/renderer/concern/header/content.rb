class TokyoMetro::App::Renderer::Concern::Header::Content < TokyoMetro::App::Renderer::Concern::Header::Title

  def initialize(
    request , domain_class_name , icon_name , text_ja , text_en ,
    domain_id_name: nil ,
    icon_size: 3 ,
    size_setting_button_type: nil  , contoller_of_size_setting: nil ,
    add_update_button: false , update_button_id: nil ,
    contoller_of_updating_real_time_info_form: nil , action_of_updating_real_time_info_form: nil ,
    additional_content: nil
  )

    raise "Error" if add_update_button and update_button_id.blank?
    raise "Error" if !( add_update_button ) and update_button_id.present?
    raise "Error" if size_setting_button_type.present? and contoller_of_size_setting.blank?
    raise "Error" if size_setting_button_type.blank? and contoller_of_size_setting.present?

    super(
    request , text_ja , text_en ,
    domain_id_name: domain_id_name ,
    domain_class_name: domain_class_name ,
    icon_name: icon_name , 
    icon_size: icon_size ,
    additional_content: additional_content
  )
    @size_setting_button_type = size_setting_button_type
    @contoller_of_size_setting = contoller_of_size_setting
    #
    @add_update_button = add_update_button
    @update_button_id = update_button_id
    @contoller_of_updating_real_time_info_form = contoller_of_updating_real_time_info_form
    @action_of_updating_real_time_info_form = action_of_updating_real_time_info_form
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ domain_class_name , :content_header ] , id: domain_id_name }

  - # icon , text

  %div{ class: :icon }<
    = ::TokyoMetro::App::Renderer::Icon.send( icon_name , request , icon_size ).render
  - if text_ja.present?
    %div{ class: :text }
      %h3{ class: :text_ja }<
        = text_ja
      %h4{ class: :text_en }<
        = text_en
  - else
    %h3{ class: :text_en }<
      = text_en

  - # size_setting_button

  - if size_setting_button_type.present?
    %div{ id: contoller_of_size_setting , class: :size_button }<
      = form_tag( url_in_size_setting_form , remote: true , class: class_name_of_size_setting_form_button ) do
        = button_tag( type: :submit ) do
          = ::TokyoMetro::App::Renderer::Icon.minimize( request , 1 ).render

  - # add_update_button

  - if add_update_button
    %div{ id: update_button_id , class: :update_button }<
      = form_tag( url_in_updating_real_time_info_form , remote: true , class: class_name_of_updating_real_time_info_form_button ) do
        = button_tag( type: :submit ) do
          = ::TokyoMetro::App::Renderer::Icon.updating( request , 1 ).render

  - # additional_content

  - if additional_content.present?
    = additional_content.call
    HAML
  end

  private

  def h_locals
    super.merge( {
      size_setting_button_type: @size_setting_button_type ,
      contoller_of_size_setting: @contoller_of_size_setting ,
      #
      add_update_button: @add_update_button ,
      update_button_id: @update_button_id ,
      #
      # size_setting_button_id: size_setting_button_id ,
      url_in_size_setting_form: url_in_size_setting_form ,
      class_name_of_size_setting_form_button: class_name_of_size_setting_form_button ,
      #
      url_in_updating_real_time_info_form: url_in_updating_real_time_info_form ,
      class_name_of_updating_real_time_info_form_button: class_name_of_updating_real_time_info_form_button
    } )
  end

=begin
  def size_setting_button_id
    if @size_setting_button_type.present?
      "#{ @size_setting_button_type }_#{ @contoller_of_size_setting }"
    else
      nil
    end
  end
=end

  def url_in_size_setting_form
    if @size_setting_button_type.present?
      # ::Rails.application.routes.url_helpers.url_for( controller: contoller_of_size_setting , action: size_setting_button_type , host: default_url_options[ :host ] )
      # ::Rails.application.routes.url_helpers.url_for( controller: contoller_of_size_setting , action: size_setting_button_type )
      u.url_for( controller: @contoller_of_size_setting , action: @size_setting_button_type , only_path: true )
    else
      nil
    end
  end

  def class_name_of_size_setting_form_button
    if @size_setting_button_type.present?
      "ajax_link_to_#{ @contoller_of_size_setting }"
    else
      nil
    end
  end

  def url_in_updating_real_time_info_form
    if @add_update_button
      u.url_for( controller: @contoller_of_updating_real_time_info_form , action: @action_of_updating_real_time_info_form , only_path: true )
    else
      nil
    end
  end

  def class_name_of_updating_real_time_info_form_button
    if @add_update_button
      :ajax_link_to_update_real_time_info
    else
      nil
    end
  end

end