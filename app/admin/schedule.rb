ActiveAdmin.register Schedule do

  menu :parent => "Programming"

  config.sort_order = 'start_date_desc'


  index do
    selectable_column

    column :name
    column :start_date
    column :end_date

    actions

  end

  filter :name
  filter :start_date
  filter :end_date
  filter :created_at
  filter :updated_at


  show do |schedule|
    panel 'Basic details' do
      attributes_table_for schedule do
        row :id
        row :name
        row :start_date
        row :end_date
        row :created_at
        row :updated_at
      end
    end

    panel 'Show assignments' do


      tabs do

        WeekService.days_dic.each do |day, integer|
          tab day.to_sym do

            attributes_table_for schedule do
              # TODO: assignments before 7 o clock are not ordered correctly.
              # This is a bug and needs to be fixed
              schedule.assignments_on(integer).order(end_time: :asc).each do |assignment|
                  div '(' + (format_time(assignment.start_time) +
                  ' - ' + format_time(assignment.end_time)) +
                  ')' + ' ' + assignment.show.title
              end
            end
          end
        end


      end



    end
  end

  form do |f|
    f.inputs name: 'Basic details' do
      f.input :name
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    # TODO: display better, at least order by date and time :(
    f.inputs name: 'Show assignments' do
      f.has_many :assignments, allow_destroy: true do |sf|
        sf.input :start_time
        sf.input :end_time
        sf.input :day_of_week, as: :select, collection: WeekService.days_dic
        sf.input :show_id, :label => 'Show', as: :select, :collection => Show.by_title
      end


    end

    f.actions
  end

  permit_params :name, :start_date, :end_date, assignments_attributes: [:id, :day_of_week, :start_time, :end_time, :show_id, :_destroy]


end
