#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "FreshAir.org.uk"
    xml.description "Edinburgh's Student Radio Station"
    xml.link root_url
    xml.language "en"

    @all_posts.each do |post|
      xml.item do
        xml.title post.title
        xml.author post.author
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post.id
        xml.description post.content

      end
    end
  end
end
