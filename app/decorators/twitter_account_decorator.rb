class TwitterAccountDecorator < Draper::Decorator
  delegate_all

  def render( title )
    h.render inline: <<-HAML , type: :haml , locals: { link_url: link_url , title: title , widget_id: widget_id }
= link_to( title , link_url , "data-widget-id" => widget_id , "data-chrome" => :nofooter , class: "twitter-timeline" , width: 240 , height: 320 )
    HAML
  end

  def self.embed_twitter_script
    h.render( partial: "twitter_script" , type: :html )
  end

  private

  def link_url
    "https://twitter.com/#{ object.name }"
  end

end