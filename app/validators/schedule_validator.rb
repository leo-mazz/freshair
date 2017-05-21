class ScheduleValidator <  ActiveModel::Validator
  def validate(record)
    record.assignments.each do |assignment|
      if not assignment.compatible_with?(record.assignments)
        record.errors[:name] << "There are clashes in the assignments"
      end
    end
  end
end
