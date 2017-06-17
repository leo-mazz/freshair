ActiveAdmin.register Schedule do

  menu :parent => "Programming"

  config.sort_order = 'updated_at_desc'

  member_action :set_current, :method => :post do
    schedule = Schedule.find(params[:id])
    schedule.set_current
    redirect_to admin_schedules_path

    # Notify user of success or failure
    if schedule.errors.empty?
      flash[:notice] = "Schedule successfully set as current!"
    else
      schedule.errors.each do |attribute, message|
        flash[:errors] = "#{attribute}: #{message}"
      end
    end

  end

  member_action :set_non_current, :method => :post do
    schedule = Schedule.find(params[:id])
    schedule.set_non_current
    redirect_to admin_schedules_path

    # Notify user of success or failure
    if schedule.errors.empty?
      flash[:notice] = "Schedule successfully set as not current!"
    else
      schedule.errors.each do |attribute, message|
        flash[:errors] = "#{attribute}: #{message}"
      end
    end

  end


  index do
    selectable_column

    column :name
    column :is_current
    column :end_date
    column "Next schedule", :next_schedule

    actions

    column '' do |schedule|
      if schedule.is_current
        link_to 'Set as not current', set_non_current_admin_schedule_path(schedule), method: :post
      elsif not schedule.past?
        link_to 'Set as current', set_current_admin_schedule_path(schedule), method: :post
      end
    end

    # column :created_at
    # column :updated_at

  end

  filter :name
  filter :is_current
  filter :end_date
  filter :created_at
  filter :updated_at


  show do |schedule|
    panel 'Basic details' do
      attributes_table_for schedule do
        row :id
        row :name
        row :is_current
        row :end_date
        row :next_schedule
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
      f.input :end_date, as: :datepicker
      f.input :next_schedule, collection: Schedule.where.not(id: f.object.id)
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

  permit_params :name, :end_date, :next_schedule_id, assignments_attributes: [:id, :day_of_week, :start_time, :end_time, :show_id, :_destroy]


end
