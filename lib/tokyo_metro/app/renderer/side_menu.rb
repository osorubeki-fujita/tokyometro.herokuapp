class TokyoMetro::App::Renderer::SideMenu < TokyoMetro::App::Renderer::MetaClass

  def self.render_all( request )
    h.render inline: <<-HAML , type: :haml , locals: { all_list: all_list( request ) }
%div{ id: :side_menu }
  - all_list.each do | list |
    = list.render
    HAML
  end

  private

  class << self

    def list_class_name
      ::TokyoMetro::App::Renderer::SideMenu::Link::List
    end

    def list_names
      [ :to_main_contents , :to_documents , :to_other_websites ]
    end

    def all_list( request )
      list_names.map { | list_name | list_class_name.send( list_name , request ) }
    end

  end

end