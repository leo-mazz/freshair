ActiveAdmin.register Tag do

  menu :parent => "Content"

  permit_params :name, :is_post_type

  index do
    selectable_column
    column :name
    column :is_post_type
    column :posts do |tag|
      tag.posts.count
    end
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name

      if current_user.has_role? :admin
        f.input :is_post_type
      end
    end


    f.actions
  end

  show do |tag|
    panel 'Tag details' do
      attributes_table_for tag do
        row :name
        row :posts do
          tag.posts.count
        end
        row :is_post_type
      end
    end
  end

end
