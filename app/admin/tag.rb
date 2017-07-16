ActiveAdmin.register Tag do

  menu :parent => "Content"

  permit_params :name, :is_post_type, :is_highlighted, :pic

  member_action :delete_pic, :method => :post do
    tag = Tag.find(params[:id])
    tag.remove_pic = true
    tag.is_highlighted = false
    tag.save
    redirect_to admin_tags_path

    # Notify user of success or failure
    if tag.errors.empty?
      flash[:notice] = "Picture correctly deleted. If the tag was highlighted, it is not anymore"
    else
      tag.errors.each do |attribute, message|
        flash[:errors] = "#{attribute}: #{message}"
      end
    end

  end

  index do
    selectable_column
    column :name
    column :is_post_type
    column :is_highlighted
    column :posts do |tag|
      tag.posts.count
    end
    actions
  end

  filter :name
  filter :created_at
  filter :is_post_type
  filter :is_highlighted

  form do |f|
    f.inputs do
      f.input :name

      if current_user.has_role? :admin
        f.input :is_post_type
      end

      if (current_user.has_role?(:admin) ||
        current_user.has_role?(:committee) ||
        current_user.team_manager?)
          f.input :is_highlighted, label: 'Highlight?'
          f.input :pic
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
        row :is_highlighted
        unless tag.pic.url.nil?
          row 'pic' do
            img src: tag.pic.url
          end
          row 'remove_pic' do
            link_to 'Delete picture', delete_pic_admin_tag_path(tag.id), method: :post
          end
        end
      end
    end
  end

end
