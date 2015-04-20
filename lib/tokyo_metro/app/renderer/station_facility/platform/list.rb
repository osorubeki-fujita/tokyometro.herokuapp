class TokyoMetro::App::Renderer::StationFacility::Platform::List < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , ary )
    super( request )
    @ary = ary
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :platform_info_tab_menu }
  %ul{ id: :platform_info_tabs }
    - ary.each do | info |
      = info.render_tab
  %div{ id: :platform_info_tab_contents }
    %ul
      - ary.each do | info |
        = info.render_content
    HAML
  end

  private

  def h_locals
    super.merge({
      ary: @ary
    })
  end

end