class BookingValidator < ActiveModel::Validator

  def validate(record)

    if record.start <= (Time.now + (60*60*24))
      record.errors[:start] << "You should book at least 24 hours in advance"
    end

    if record.end <= record.start
      record.errors[:end] << "The end time of the booking must come after the start time"
    end

    if (record.end.to_i - record.start.to_i) > (4*60*60)
      record.errors[:end] << "You can't book for more than 4 hours"
    end

    if record.location == 1
      schedule = Schedule.for_time(record.start.to_i)

      if schedule.nil?
        record.errors[:location] << "You can't book the Main Studio on that date"
      elsif !schedule.compatible_with_times?(record.start, record.end)
        record.errors[:start] << "The booking clashes with an entry on the schedule"
      end
    end


    if record.creates_clash?
      record.errors[:start] << "This booking would clash with a previous one"
    end

  end

end
