ActiveAdmin.register Show do

  menu :parent => "Programming"

  member_action :delete_pic, :method => :post do
    show = Show.find(params[:id])
    show.remove_pic = true
    show.save
    redirect_to admin_shows_path

    # Notify user of success or failure
    if show.errors.empty?
      flash[:notice] = "Picture correctly deleted"
    else
      show.errors.each do |attribute, message|
        flash[:errors] = "#{attribute}: #{message}"
      end
    end

  end

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
        row 'remove_pic' do
          link_to 'Delete picture', delete_pic_admin_show_path(show.id), method: :post
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
