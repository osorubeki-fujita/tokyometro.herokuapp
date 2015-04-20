class TokyoMetro::App::Renderer::Concern::Link::MetaClass < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , title_ja , title_en , url , icon_name: nil , class_name_of_whole_domain: nil , class_name_of_link: :link , class_name_of_text_domain: nil , open_another_window: false , size: :normal , additional_info: nil , additional_info_position: nil )
    super( request )

    raise "Error" if title_ja.blank? and title_en.blank?
    raise "Error" if class_name_of_text_domain.blank?

    raise "Error" if additional_info.present? and additional_info_position.blank?
    raise "Error" if additional_info.blank? and additional_info_position.present?

    @title_ja = title_ja
    @title_en = title_en
    @url = url
    @icon_name = icon_name
    @class_name_of_whole_domain = class_name_of_whole_domain
    @class_name_of_link = class_name_of_link
    @class_name_of_text_domain = class_name_of_text_domain
    @open_another_window = open_another_window
    @size = size

    @additional_info = additional_info
    @additional_info_position = additional_info_position
  end

  def render
    _h_locals = h_locals
    h.render inline: <<-HAML , type: :haml , locals: _h_locals
%li{ class: li_class_name }<
  = v.link_to_unless( ( request.fullpath == url ) , "" , url , only_path_setting: false , class: class_name_of_link , target: target )
  %div{ class: class_name_of_text_domain }<
    - if icon_name.present?
      %div{ class: :icon }
        = ::TokyoMetro::App::Renderer::Icon.send( icon_name , request ).render
    - if title_ja.present? and title_en.present?
      %div{ class: :text }
        - if title_ja.instance_of?( ::Array )
          %div{ class: :text_ja }<
            - title_ja.each do | row |
              %p<
                = row
        - else
          %p{ class: :text_ja }<
            = title_ja
        - if title_en.instance_of?( ::Array )
          %div{ class: :text_en }<
            - title_ja.each do | row |
              %p<
                = row
        - else
          %p{ class: :text_en }<
            = title_en
      - if additional_info.present?
        = additional_info.call
    - else
      %div{ class: :text_large }
        - if title_ja.present?
          - text = title_ja
        - elsif title_en.present?
          - text = title_en
        - if text.instance_of?( ::Array )
          - text.each do | row |
            %p<
              = row
        - else
          %p<
            = text
      - if additional_info.present?
        = additional_info.call
    HAML
  end

  private

  def open_another_window?
    @open_another_window
  end

  def target
    if open_another_window?
      :_blank
    else 
      nil
    end
  end

  def h_locals
    super.merge( {
      title_ja: @title_ja ,
      title_en: @title_en ,
      url: @url ,
      icon_name: @icon_name ,
      class_name_of_link: [ @class_name_of_link ].flatten.uniq.sort ,
      class_name_of_text_domain: @class_name_of_text_domain ,
      li_class_name: li_class_name ,
      target: target ,
      additional_info: @additional_info ,
      additional_info_position: @additional_info_position
    } )
  end

  def li_class_name
    if @class_name_of_whole_domain.present?
      [ @class_name_of_whole_domain , @size ].flatten
    else
      @size
    end
  end

end