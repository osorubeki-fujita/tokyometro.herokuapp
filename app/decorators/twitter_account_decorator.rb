class TwitterAccountDecorator < Draper::Decorator
  delegate_all

  def render( title )
    h.link_to( title , link_url , "data-widget-id" => object.widget_id , "data-chrome" => :nofooter , class: "twitter-timeline" , width: 240 , height: 320 )
  end

  def self.embed_twitter_script
    h.render( partial: "twitter_script" , type: :html )
  end

  private

  def link_url
    "https://twitter.com/#{ object.name }"
  end

end
