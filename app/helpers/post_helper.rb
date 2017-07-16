module PostHelper

  def post_summary(post)
    summary = post.summary
    # title will take space
    if post.title.length > 35
      summary = truncate(summary, length: 130,  separator: ' ')
    else
      summary = truncate(summary, length: 140,  separator: ' ')
    end

    return summary
  end

end
