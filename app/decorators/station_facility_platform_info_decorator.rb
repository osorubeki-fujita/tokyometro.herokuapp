class StationFacilityPlatformInfoDecorator < Draper::Decorator
  delegate_all

  def self.render_transfer_info_title
    h.render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "のりかえ"
    HAML
  end

  def self.render_inside_barrier_free_facility_title
    h.render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "改札内の"
  = tag( :br )
  = "駅設備"
    HAML
  end

  def self.render_outside_barrier_free_facility_title
    h.render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "改札外の"
  = tag( :br )
  = "駅設備"
    HAML
  end

  def self.render_surrounding_area_info_title
    h.render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "駅周辺の"
  = tag( :br )
  = "主要施設・名所"
    HAML
  end

  def self.render_link_in_tab( tab_name )
    h.link_to(
      "" ,
      h.url_for( anchor: tab_name.to_s.gsub( /\Aplatform_info_/ , "" ) ) ,
      onclick: h.raw( "changeStationFacilityPlatformInfoTabByPageLink(\'#{ tab_name }\', true ) ; return false ; " )
    )
  end

  # 中身のないセルを作成するメソッド
  def self.render_an_empty_cell
    h.render inline: <<-HAML , type: :haml
%td{ class: :empty }<
  = " "
    HAML
  end

end
