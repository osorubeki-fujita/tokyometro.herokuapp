module BottomContentHelper

  def bottom_content
    ary_of_link_methods = [ link_to_document , link_to_disclaimer , link_to_remark , link_to_tokyo_metro_official ]
    render inline: <<-HAML , type: :haml , locals: { method_name: __method__ , ary_of_link_methods: ary_of_link_methods }
%div{ id: method_name }
  %div{ class: "links" }
    - ary_of_link_methods.each.with_index(1) do | link_method , i |
      = link_method
      - unless i == ary_of_links.length
        = " | "
    HAML
  end

end