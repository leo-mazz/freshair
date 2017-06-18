ActiveAdmin.register Post do

  menu :parent => "Content"

  config.sort_order = 'created_at_desc'

  permit_params :title, :short_body, :content, :author_id, :is_published, :team_id, :show_id, tag_ids: [], post_metadata_attributes: [:id, :post_id, :key, :value, :_destroy]

  index do
    selectable_column

    column :title
    column :author if current_user.has_role? :admin
    column :is_published
    column :show
    column :team
    column :tags do |post|
      post.tags.each do |tag|
        li tag.name
      end
      ''
    end
    actions
  end

  filter :title
  filter :author
  filter :created_at
  filter :updated_at
  filter :is_published
  filter :short_body
  filter :tags

  show do |post|
    panel 'Post details' do
      attributes_table_for post do
        row :title
        row :short_body
        row :content
        row :author
        row :is_published
        row :created_at
        row :updated_at
        row :team
        row :show
        row :tags do
          post.tags.each do |tag|
            li tag.name
          end
          ''
        end
        row :metadata do
          post.post_metadata.each do |md|
            li do
              strong md.key
              span ': ' + md.value
            end
          end
          ''
        end
      end
    end
  end


  form do |f|
    f.inputs do

      if current_user.has_role? :admin
        f.input :author, collection: User.by_first_name.all
      elsif f.object.new_record?
        f.input :author_id, as: :hidden, input_html: {value: current_user.id}
      end
      f.input :title

      if f.object.new_record?
        f.input :is_published, label: "Publish?", input_html: {checked: 'checked'}
      else
        f.input :is_published, label: "Publish?"
      end

      f.input :short_body
      f.input :content
      f.input :tags, as: :check_boxes

      if current_user.has_role? :admin
        f.input :show, as: :select, collection: Show.by_title, label: 'Associate to a show?'
        f.input :team, as: :select, collection: Team.all, label: 'Associate to a team?'
      else
        f.input :show, as: :select, collection: current_user.shows, label: 'Associate to a show?'
        f.input :team, as: :select, collection: current_user.teams, label: 'Associate to a team?'
      end

    end

    f.inputs "Post metadata" do
      div 'If you\'re writing a review, the website will display a rating (with stars) if you add a metadatum with key \'rating \' and your rating (numeric, on a scale from 0 to 10) as the value',  style:'margin-left:15px;'
      f.has_many :post_metadata, :allow_destroy => true do |tmf|
        tmf.input :key, as: :select, collection: PostMetadatum.allowed_keys
        tmf.input :value
      end
    end

    f.actions
  end

end
