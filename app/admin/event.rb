ActiveAdmin.register Event do

  scope :upcoming

  config.sort_order = 'start_desc'
  index do
    selectable_column
    column :name
    column(:is_upcoming) do |event|
      event.is_upcoming? ? status_tag( "yes", :ok ) : status_tag( "no" )
    end
    column :start
    column :end
    column :location
    actions
  end

  filter :name
  filter :start
  filter :end
  filter :location
  filter :description
  filter :created_at
  filter :updated_at

  show do |event|
    panel 'Event Details' do
      attributes_table_for event do
        row :name
        row :is_upcoming do
          event.is_upcoming? ? status_tag( "yes", :ok ) : status_tag( "no" )
        end
        row :start
        row :end
        row :location
        row :description do
          # REMEMBER TO SANITIZE!! We don't want unsafe code to be put here
          sanitize event.description.html_safe
        end
        row :facebook_event do
          unless event.facebook_event.blank?
            link_to event.facebook_event, event.facebook_event
          end
        end
        row :link_to_tickets do
          unless event.link_to_tickets.blank?
            link_to event.link_to_tickets, event.link_to_tickets
          end
        end
        row :created_at
        row :updated_at
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :start
      f.input :end
      f.input :description, as: :html_editor
      f.input :location
      f.input :facebook_event
      f.input :link_to_tickets
    end
    f.actions
  end

  permit_params :name, :start, :end, :description, :location, :facebook_event, :link_to_tickets
end
