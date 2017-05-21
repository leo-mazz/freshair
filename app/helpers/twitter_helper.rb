module TwitterHelper

  def auto_link_tweet(tweet)
    html = tweet.text
    html = html.gsub(/@(?<user>.+?\b)/, "<a href=\"http://twitter.com/\\k<user>\">@\\k<user></a>")
    html = html.gsub(/(?<tag>#.+?\b)/, "<a href=\"http://twitter.com/\\k<tag>\">\\k<tag></a>")
    html = auto_link(html)
    return html
  end

end
