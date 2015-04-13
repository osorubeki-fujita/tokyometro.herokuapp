class TokyoMetro::App::Renderer::Twitter::Header < TokyoMetro::App::Renderer::Concern::Header::Content

  def initialize( request , visibility: :visible , icon_size: 2 )
    @visibility = visibility
    super(
      request ,
      :twitter_header ,
      :twitter_square ,
      "" ,
      "Twitter" ,
      icon_size: icon_size ,
      size_setting_button_type: size_setting_button_type ,
      contoller_of_size_setting: :twitter ,
      add_update_button: false ,
      update_button_id: nil ,
      additional_content: nil
    )
  end

  private

  def size_setting_button_type
    case @visibility
    when :visible
      :minimize
    when :hidden
      :display
    end
  end

end