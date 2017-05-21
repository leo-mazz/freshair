class ScheduleAssignmentValidator < ActiveModel::Validator

  def validate(record)
      if record.end_time <= record.start_time
        record.errors[:end_time] << "The end time of an assignment needs to come after the start time"
      end
    end
    
end
