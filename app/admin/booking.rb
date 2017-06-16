ActiveAdmin.register Booking do

  scope :future
  scope :recording_studio_next_7_days

  permit_params :user, :start, :end, :location

  config.sort_order = 'start_asc'

  # Automatically set current user as booking owner
  before_create do |booking|
    booking.user = current_user
  end

  index do
    selectable_column

    column :location do |booking|
      Booking.locations.key(booking.location)
    end
    column :user
    column :start
    column :end

    actions
  end

  form do |f|
    f.inputs do
      f.input :location, as: :select, collection: Booking.locations
      f.input :start
      f.input :end
    end

    f.actions
  end


end
