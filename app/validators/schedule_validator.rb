class ScheduleValidator <  ActiveModel::Validator

  def validate(record)
    record.assignments.each do |assignment|
      if not assignment.compatible_with?(record.assignments)
        record.errors[:name] << 'There are clashes in the assignments'
      end
    end

    if (!record.start_date.blank? &&
      !record.end_date.blank? &&
      (record.end_date < record.start_date))
        record.errors[:end_date] << 'The end date cannot be before the start date'
    end

    if !record.start_date.blank? && record.end_date.blank?
      record.errors[:end_date] << 'If you specify a start date you have to give an end date'
    end

    if record.start_date.blank? && !record.end_date.blank?
      record.errors[:end_date] << 'If you specify an end date you have to give a start date'
    end

    Schedule.all.each do |schedule|
      if record.clash_with?(schedule)
        record.errors[:name] << 'There is a date clash between this schedule and another one'
      end
    end
  end

end
