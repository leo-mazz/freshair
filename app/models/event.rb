class Event < ApplicationRecord

  validates_presence_of :name, :start, :description, :location
  validates_with EventValidator

  def is_upcoming?
    self.start >= Time.now
  end

  def self.upcoming
    Event.where("start >= ?", Time.now).order(:start)
  end

  def single_day?
    return true if self.end.nil?
    self.start.to_date == self.end.to_date
  end

end
