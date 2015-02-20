module PlatformInfoTabHelper

  private

  # 乗車位置情報のタブを作成
  def platform_infos_tabs( railway_line_ids , yf: false , ni: false )
    raise "Error" if yf and ni

    if yf or ni
      if yf
        tab_name = @default_platform_info_tab
        railway_line_name_ja = "有楽町線・副都心線"
        railway_line_name_en = "Yurakucho and Fukutoshin Line"
      elsif ni
        tab_name = @default_platform_info_tab
        div_class_name = :namboku_and_toei_mita
        railway_line_name_ja = "南北線・都営三田線"
        railway_line_name_en = "Namboku and Toei Mita Line"
      end

      h_locals = {
        railway_line_ids: railway_line_ids ,
        tab_name: tab_name ,
        railway_line_name_ja: railway_line_name_ja ,
        railway_line_name_en: railway_line_name_en
      }
      render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :platform_info_tabs }
  %ul
    %li{ class: [ tab_name , :platform_info_tab ] }<
      = platform_infos_link_in_tab( tab_name )
      %div{ class: :railway_line_name }
        - railway_line_ids.each do | railway_line_id |
          - railway_line_instance = ::RailwayLine.find( railway_line_id )
          %div{ class: railway_line_instance.css_class_name }
            = railway_line_instance.decorate.render_railway_line_code( small: true )
        %div{ class: :text }<
          %div{ class: :text_ja }<
            = railway_line_name_ja
          %div{ class: :text_en }<
            = railway_line_name_en
      HAML

    else

      render inline: <<-HAML , type: :haml , locals: { railway_line_ids: railway_line_ids }
%div{ id: :platform_info_tabs }
  %ul
    - railway_line_ids.sort.each do | railway_line_id |
      - railway_line_instance = ::RailwayLine.find( railway_line_id )
      - tab_name = "platform_info_" + railway_line_instance.css_class_name
      %li{ class: [ tab_name , :platform_info_tab ] }<
        = platform_infos_link_in_tab( tab_name )
        %div{ class: :railway_line_name }
          %div{ class: railway_line_instance.css_class_name }
            = railway_line_instance.decorate.render_railway_line_code( small: true )
          %div{ class: :text }<
            %div{ class: :text_ja }<
              = railway_line_instance.name_ja
            %div{ class: :text_en }<
              = railway_line_instance.name_en
      HAML
    end

  end

  def platform_infos_link_in_tab( tab_name )
    render inline: <<-HAML , type: :haml , locals: { tab_name: tab_name }
= link_to( "" , url_for( anchor: tab_name ) , onclick: raw( "changePlatformInfoTab('" + tab_name.to_s + "'); return false;" ) )
    HAML
  end

end