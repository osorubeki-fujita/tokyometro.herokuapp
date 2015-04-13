class TokyoMetro::App::Renderer::SideMenu::NowDeveloping::Header < TokyoMetro::App::Renderer::Concern::Header::Content

  def initialize( request , icon_size: 2 )
    super(
      request ,
      :remark ,
      :remark ,
      "ご利用上の注意" ,
      "Please note" ,
      icon_size: icon_size ,
      size_setting_button_type: nil ,
      contoller_of_size_setting: nil ,
      add_update_button: false ,
      update_button_id: nil ,
      additional_content: nil
    )
  end

end