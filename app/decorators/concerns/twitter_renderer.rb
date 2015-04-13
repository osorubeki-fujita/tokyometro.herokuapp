module TwitterRenderer

  def render_twitter_widget
    raise "Error" unless twitter_widget_id.present?
    h.content_tag( :div , class: :twitter ) do
      h.concat( render_twitter_widget_domain + render_twitter_script )
    end
  end

  private

  def render_twitter_widget_domain
    h.link_to( twitter_title , twitter_link_url ,
      "data-widget-id" => twitter_widget_id ,
      "data-chrome" => :nofooter ,
      class: "twitter-timeline" ,
      width: 240 ,
      height: 320
    )
  end

  def render_twitter_script
    h.render( partial: "twitter_script" , type: :html )
  end

  def twitter_link_url
    "https://twitter.com/#{ object.twitter_account }"
  end

end