class TokyoMetro::App::Renderer::SideMenu::Link::ToOtherWebsite::Info < TokyoMetro::App::Renderer::SideMenu::Link::MetaClass::Info

  def initialize( request , title_ja , title_en , url , icon_name: nil )
    super(
      request ,
      title_ja ,
      title_en ,
      url ,
      icon_name: icon_name ,
      class_name_of_link: :link ,
      class_name_of_text_domain: :link_to_other_website ,
      open_another_window: true ,
      size: :small
    )
  end

  def self.tokyo_metro_official( request )
    self.new(
      request ,
      "東京メトロ［公式］" ,
      "Tokyo Metro Official Page" ,
      "http://www.tokyometro.jp/index.html" ,
      icon_name: :tokyo_metro
    )
  end

  def self.top_of_opendata_contest( request )
    self.new(
      request ,
      [ "オープンデータ" , "活用コンテスト" ] ,
      "Open Data Competition" ,
      "http://tokyometro10th.jp/future/opendata/index.html" ,
      icon_name: :contest
    )
  end

  def self.top_for_developer( request )
    self.new(
      request ,
      [ "オープンデータ" , "開発者サイト" ] ,
      "Developers' page" ,
      "https://developer.tokyometroapp.jp/" ,
      icon_name: :development
    )
  end

end