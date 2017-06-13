class EventValidator < ActiveModel::Validator

  def validate(record)
    unless (record.facebook_event.starts_with? 'https://') || (record.facebook_event.starts_with? 'http://') || (record.facebook_event.blank?)
      record.errors[:facebook_event] << "This doesn't look like a valid URL"
    end

    unless (record.link_to_tickets.starts_with? 'https://') || (record.link_to_tickets.starts_with? 'http://') || (record.link_to_tickets.blank?)
      record.errors[:link_to_tickets] << "This doesn't look like a valid URL"
    end
  end

end
