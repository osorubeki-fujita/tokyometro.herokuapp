module ColorBoxHelper

  def color_box( small: false )
    render inline: <<-HAML , type: :haml , locals: { class_name: css_class_name_of_color_box( small ) }
%div{ class: class_name }<
    HAML
  end

  private

  def css_class_name_of_color_box( small )
    if small
      :color_box_32
    else
      :color_box_48
    end
  end

end