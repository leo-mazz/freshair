ActiveAdmin.register Podcast do

  menu :parent => "Content"

  permit_params :title, :description, :uri, :broadcast_date, :show_id, played_tracks_attributes: [:id, :podcast, :artist, :title, :album, :_destroy]

  index do
    selectable_column
    column :show
    column :title
    column :broadcast_date
    actions
  end

  filter :show, as: :select, collection: proc { current_user.shows }
  filter :broadcast_date
  filter :title
  filter :description
  filter :uri, label: 'Mixcloud URL'
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :show, collection: current_user.all_shows
      f.input :broadcast_date
      f.input :uri, label: 'Mixcloud URL'
      f.input :title
      f.input :description
    end

    f.inputs "Playlist" do
      f.has_many :played_tracks, :allow_destroy => true do |tmf|
        tmf.input :artist
        tmf.input :title
        tmf.input :album
      end
    end

    f.actions
  end


end
