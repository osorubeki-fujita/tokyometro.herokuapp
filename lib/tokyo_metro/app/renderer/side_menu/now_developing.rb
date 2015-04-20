class TokyoMetro::App::Renderer::SideMenu::NowDeveloping < TokyoMetro::App::Renderer::MetaClass

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :now_developing }
  = ::TokyoMetro::App::Renderer::SideMenu::NowDeveloping::Header.new( request ).render
  %div{ class: :info_text }
    %div{ class: :text_ja }
      - [ "ただいま開発中につき" , "間違っている情報が" , "含まれている場合があります" ].each do | row |
        %p<
          = row
    %div{ class: :text_en }
      %p<
        = "The library 'Rails on Ruby' and this web-application has been developed now. Please note that some contents in this app may be wrong."
    HAML
  end

end