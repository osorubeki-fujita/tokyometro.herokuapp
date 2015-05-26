module DocumentHelper

  def self.common_title_ja
    "ドキュメント" # "開発ドキュメント"
  end

  def self.common_title_en
    "Documents" # "Documents of development"
  end

  def render_to_do( contents )
    render inline: <<-HAML , type: :haml , locals: { contents: contents }
- if contents.present?
  - contents.each do | item |
    - if item.string?
      %li{ class: :content }<
        = item
    - elsif item.instance_of?( ::Hash )
      %li{ class: :content }
        %div{ class: :main }<
          = item[ "title" ]
        %ul{ class: :contents }
          = render_to_do( item[ "contents" ] )
    HAML
  end

end
