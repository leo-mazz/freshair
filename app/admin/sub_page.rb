ActiveAdmin.register SubPage do

  menu :parent => "Pages"

  config.sort_order = 'page_id_desc'

  index do
    selectable_column
    column :title
    column 'Parent page', :page
    column :priority
    actions
  end

  filter :title
  filter :page, label: 'Parent page'
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :page, label: 'Parent page'
      f.input :title
      f.input :content, as: :ckeditor, input_html: { ckeditor: { toolbar: 'mini', height: 400 } }
      f.input :priority
    end
    f.actions
  end

  show do |sub_page|
    panel 'Sub Page Details' do
      attributes_table_for sub_page do
        row :title
        row :content do
          # REMEMBER TO SANITIZE!! We don't want unsafe code to be put here
          sanitize sub_page.content.html_safe
        end
        row :parent_page do
          sub_page.page
        end
        row :priority
        row :created_at
        row :updated_at
      end
    end
  end

  permit_params :title, :content, :page_id, :priority

end
