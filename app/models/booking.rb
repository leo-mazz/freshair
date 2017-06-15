class Booking < ApplicationRecord

  belongs_to :user
  validates_presence_of :start, :end, :user, :location
  validates_with BookingValidator

  def self.future
    Booking.where("start >= ?", Time.now).order(:start)
  end

  def clash_with?(booking)
    # Two bookings clash if they are in the same place and
    (self.location == booking.location) &&
      # either the first contains the second
      (((self.start <= booking.start) && (self.end >= booking.end)) ||
        # or the first starts while the second is on,
        ((self.start >= booking.start) && (self.start < booking.end)) ||
        # or if the first ends while the second is on
        ((self.end > booking.start) && (self.end <= booking.end)))
  end

  def creates_clash?
    Booking.future.each do |a|
      return true if self.clash_with?(a)
    end

      false
  end

end
