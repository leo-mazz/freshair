class PostValidator < ActiveModel::Validator

  def validate(record)
    unless record.show_id.blank?
      if !record.author.shows.include?(record.show)
        record.errors[:show_id] << "You don't have the authority to associate to this show"
      end
    end

    unless record.team_id.blank?
      if !record.author.teams.include?(record.team)
        record.errors[:team_id] << "You can't associate a team you're not part of"
      end
    end
  end

end
