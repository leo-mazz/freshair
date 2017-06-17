ActiveAdmin.register Tag do

  menu :parent => "Content"

  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do |page|
    panel 'Tag details' do
      attributes_table_for page do
        row :name
      end
    end
  end

end
