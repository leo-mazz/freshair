class ScheduleValidator <  ActiveModel::Validator
  def validate(record)
    record.assignments.each do |assignment|

      if not assignment.compatible_with?(record.assignments)
        record.errors[:name] << 'There are clashes in the assignments'
      end

      if record.next_schedule == record
        record.errors[:next_schedule_id] << 'You cannot assign as successor for a schedule itself'
      end

    end
  end
end
