class TokyoMetro::App::Renderer::SideMenu::Link::MetaClass::Info < TokyoMetro::App::Renderer::Concern::Link::MetaClass

  def initialize( request , title_ja , title_en , url , icon_name: nil , class_name_of_link: :link , class_name_of_text_domain: nil , open_another_window: false , size: :normal , additional_info: nil , additional_info_position: nil )
    super(
      request , title_ja , title_en , url ,
      icon_name: icon_name ,
      class_name_of_link: class_name_of_link ,
      class_name_of_text_domain: class_name_of_text_domain ,
      open_another_window: open_another_window ,
      size: size ,
      additional_info: additional_info ,
      additional_info_position: additional_info_position
    )
  end

end