class Event < ApplicationRecord
  
  validates_presence_of :name, :start, :description, :location

  def is_upcoming?
    self.start >= Time.now
  end

  def self.all_upcoming
    Event.where("start >= ?", Time.now)
  end

end
