#! ruby -Ku
# -*- coding: utf-8 -*-

module PlatformInfoTitleHelper

  def platform_infos_transfer_info_title
    render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "のりかえ"
    HAML
  end

  def platform_infos_barrier_free_info_title_inside
    render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "改札内の"
  = tag( :br )
  = "駅設備"
    HAML
  end

  def platform_infos_barrier_free_info_title_outside
    render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "改札外の"
  = tag( :br )
  = "駅設備"
    HAML
  end

  def platform_infos_surrounding_area_info_title
    render inline: <<-HAML , type: :haml
%td{ class: :title }<
  = "駅周辺の"
  = tag( :br )
  = "主要施設・名所"
    HAML
  end

end