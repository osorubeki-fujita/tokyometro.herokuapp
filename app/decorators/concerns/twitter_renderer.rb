module TwitterRenderer

  def twitter_link_url
    "https://twitter.com/#{ object.twitter_account }"
  end

  def render_twitter_widget
    h.content_tag( :div , class: :twitter ) do
      h.concat( render_twitter_widget_domain + render_twitter_script )
    end
  end

  def render_twitter_widget_domain
    h.link_to( twitter_title , twitter_link_url ,
        "data-widget-id" => twitter_widget_id ,
        class: "twitter-timeline" ,
        width: 240
      )
  end

  def render_twitter_script
    h.render( partial: "twitter_script" , type: :html )
  end

end