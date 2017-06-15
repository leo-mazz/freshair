class Event < ApplicationRecord

  validates_presence_of :name, :start, :description, :location
  validates_with EventValidator

  def is_upcoming?
    self.start >= Time.now
  end

  def self.upcoming
    Event.where("start >= ?", Time.now)
  end

end
