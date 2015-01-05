require 'feedzirra'

feed_urls = Array.new

# 更新情報
feed_urls << "feed://www.tokyometro.jp/update/rss/update.xml" 
# ニュースリリース
feed_urls << "feed://www.tokyometro.jp/news/rss/news.xml"
# イベント情報
feed_urls << "feed://www.tokyometro.jp/enjoy/event/rss/event.xml"


feed_urls.each do | feed_url |
  feed = Feedjira::Feed.fetch_and_parse(feed_urls.first)
  
  p feed.title          # => "PILOG"
  p feed.url            # => "http://xoyip.hatenablog.com/"
  p feed.feed_url       # => "http://xoyip.hatenablog.com/feed"
  p feed.etag           # => "f6ce826cbbd07e222b6cee445fc981f730ad0693"
  p feed.last_modified  # => 2014-01-15 11:47:34 UTC
  p feed.entries.count  # => 7
  p ""
end