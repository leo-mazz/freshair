ActiveAdmin.register Page, as: 'Main Page' do

  menu :parent => "Pages"

  index do
    selectable_column
    column :title
    column :priority
    column :slug
    actions
  end

  filter :title
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :content, as: :ckeditor, input_html: { ckeditor: { toolbar: 'mini', height: 400 } }
      f.input :priority
    end
    f.actions
  end

  show do |page|
    panel 'Page Details' do
      attributes_table_for page do
        row :title
        row :content do
          # REMEMBER TO SANITIZE!! We don't want unsafe code to be put here
          sanitize page.content.html_safe
        end
        row :slug
        row :priority
        row :created_at
        row :updated_at
      end
    end
  end

  permit_params :title, :content, :slug, :priority

end
