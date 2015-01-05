#! ruby -Ku
# -*- coding: utf-8 -*-

module PlatformInfoProcHelper

  def platform_infos_transfer_info_proc_for_display
    Proc.new { | info | platform_infos_transfer_info_proc_for_display_sub( info ) }
  end

  def platform_infos_transfer_info_proc_for_display_sub( info )
    render inline: <<-HAML , type: :haml , locals: { info: info }
- unless info.railway_line.same_as == "odpt.Railway:Tobu.SkyTreeIsesaki"
  = info.railway_line.name_ja
- else
  = "東武スカイツリーライン"
= tag( :br )
- unless info.railway_direction.blank?
  %span{ class: :direction }<>
    = info.railway_direction.station.name_ja + "方面"
%span{ class: :time }<
  = "（" + info.necessary_time.to_s + "分）"
    HAML
  end

  def platform_infos_transfer_info_proc_for_decision
    Proc.new { | info |
      info.map { | i |
        r , d , t = i.railway_line.id , i.railway_direction , i.necessary_time
        if d.nil?
          [ r , nil , t ]
        else
          [ r , d.id , t ]
        end
      }
    }
  end

end