ActiveAdmin.register Show do

  menu :parent => "Programming"

  index do
    selectable_column

    column :title

    actions
  end


  filter :title
  filter :created_at

  show do |show|
    panel 'Show Details' do
      attributes_table_for show do
        row :title
        row :tag_line
        row :description
        row :slug
        row :created_at
        row :updated_at
        row 'pic' do
          img src: show.pic.resized.url
        end
        row 'People involved' do
          show.show_memberships.each do |membership|
            li membership.user.name
          end
          ''
        end
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :title
      f.input :tag_line
      f.input :description
      f.input :pic
    end


    f.inputs "People involved" do



      f.has_many :show_memberships, :allow_destroy => true do |tmf|
        tmf.input :user, collection: User.valid
        # tmf.input :roles, collection: Show.roles_list, as: :check_boxes
      end
    end

    f.actions
  end


  permit_params :title, :tag_line, :description, :slug, :pic, show_memberships_attributes: [:id, :show_id, :user_id, :_destroy]
end
