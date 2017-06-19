ActiveAdmin.register Team do

  permit_params :name, :body, :display_order, team_memberships_attributes: [:id, :team_id, :user_id, :_destroy]

  filter :name

  index do
    if current_user.has_role? :admin
      column :display_order
    end
    column :name
    column :posts_published do |team|
      team.posts.count
    end
    column :members do |team|
      team.users.count
    end

    actions
  end

  show do |team|
    panel 'Team Details' do
      attributes_table_for team do
        row :name
        row :body do
          sanitize team.body.html_safe
        end
        if current_user.has_role? :admin
          row :display_order
        end
        row :posts_published do
          team.posts.count
        end

        row :members do
          team.users.count
        end
      end
    end
  end

  form do |f|
    f.inputs do
      if current_user.has_role? :admin
        f.input :name
        f.input :display_order
      end
      f.input :body, as: :ckeditor, input_html: { ckeditor: { toolbar: 'mini', height: 400 } }
    end

    f.inputs "Members" do
      f.has_many :team_memberships, :allow_destroy => true do |tmf|
        tmf.input :user, collection: User.by_first_name
      end
    end

    actions
  end

end
