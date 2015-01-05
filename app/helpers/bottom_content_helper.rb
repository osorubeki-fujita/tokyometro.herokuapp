#! ruby -Ku
# -*- coding: utf-8 -*-

module BottomContentHelper

  def bottom_content
    arr_of_links = [ link_to_document , link_to_disclaimer , link_to_remark , link_to_tokyo_metro_official ]
    render inline: <<-HAML , type: :haml , locals: { method_name: __method__ , arr_of_links: arr_of_links }
%div{ id: method_name }
  %div{ class: "links" }
    - last_index = arr_of_links.length - 1
    - arr_of_links.each_with_index do | link_method , i |
      = link_method
      - unless i == last_index
        = " | "
    HAML
  end

end