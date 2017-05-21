class ShowMembershipValidator <  ActiveModel::Validator

  def validate(record)
    unless record.user.has_role? :show_manager
      record.errors[:user_id] << "The user assigned to the show must be a host"
    end
  end

end
