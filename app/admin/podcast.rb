ActiveAdmin.register Podcast do

  menu :parent => "Posts"

  permit_params :title, :description, :uri, :broadcast_date, :show_id

  index do
    selectable_column
    column :show
    column :title
    column :broadcast_date
    actions
  end

  filter :show, as: :select, collection: proc { Show.of_user(current_user) }
  filter :broadcast_date
  filter :title
  filter :description
  filter :uri, label: 'Mixcloud URL'
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :show, collection: Show.of_user(current_user)
      f.input :broadcast_date
      f.input :uri, label: 'Mixcloud URL'
      f.input :title
      f.input :description
    end

    f.actions
  end


end