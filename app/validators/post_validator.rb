class PostValidator < ActiveModel::Validator

  def validate(record)

    unless record.show_id.blank?
      if !record.author.shows.include?(record.show)
        record.errors[:show_id] << "The author of the post must be associated to the show you're referencing"
      end
    end

    unless record.team_id.blank?
      if !record.author.teams.include?(record.team)
        record.errors[:team_id] << "The author of the post must be a member of the team you're referencing"
      end
    end

    if record.is_published && record.content.blank?
      record.errors[:content] << "You can't publish a post with no content"
    end

    if record.is_highlighted && record.pic_url.nil?
      record.errors[:is_highlighted] << 'You can\'t highlight a post that does not have a picture'
    end

  end

end
