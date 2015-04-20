class TokyoMetro::App::Renderer::StationLinkList::MetaClass < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , stations )
    super( request )
    @stations = stations
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ id: domain_id }
  - groups_of_letters.each do | group |
    %ul{ class: domain_class_name_of_column }
      - group.each do | letter |
        - name_list_in_a_letter = stations_grouped_by_first_letter[ letter ]
        - if name_list_in_a_letter.present?
          %li{ class: domain_class_name_of_each_letter }
            %h4{ class: :letter }<
              = letter
            %ul{ class: :stations }
              - name_list_in_a_letter.sort_by { | station | proc_for_sorting_name_list_in_a_letter_category.call( station ) }.each do | station |
                %li{ class: :station }<
                  = proc_for_render_link.call( station )
    HAML
  end

  private

  def h_locals
    super.merge({
      stations_grouped_by_first_letter: stations_grouped_by_first_letter ,
      proc_for_sorting_name_list_in_a_letter_category: proc_for_sorting_name_list_in_a_letter_category ,
      proc_for_render_link: proc_for_render_link ,
      domain_id: domain_id ,
      domain_class_name_of_column: domain_class_name_of_column ,
      domain_class_name_of_each_letter: domain_class_name_of_each_letter ,
      groups_of_letters: groups_of_letters
    })
  end

  def stations_grouped_by_first_letter
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

  def proc_for_sorting_name_list_in_a_letter_category
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

  def proc_for_render_link
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

  def domain_id
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

  def domain_class_name_of_column
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

  def domain_class_name_of_each_letter
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

  def groups_of_letters
    raise "Error: This method \'#{ __method__ }\' is not defined yet."
  end

end