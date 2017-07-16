class HighlightsService

  def self.get_highlights
    # Get max highlights for all models
    posts = Post.where(is_highlighted: true).order(created_at: :desc).limit(3)
    tags = Tag.where(is_highlighted: true).order(created_at: :desc).limit(3)
    # Wrap them in hashes and concatenate them
    posts = wrap_posts(posts)
    tags = wrap_tags(tags)
    all = tags.concat(posts)
    # Sort them by creation date (decreasing)
    all.sort_by! { |element| element[:created_at] }
    all.reverse!
    # Return at most 3
    return all[0..2]
  end

  private

    def self.wrap_posts(posts)
      posts.to_a.map do |post|
        {created_at: post.created_at, title: post.title, pic: post.pic_url, element: post}
      end
    end

    def self.wrap_tags(tags)
      tags.to_a.map do |tag|
        {created_at: tag.created_at, title: tag.name, pic: tag.pic.url, element: tag}
      end
    end

end
