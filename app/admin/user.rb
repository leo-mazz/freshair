ActiveAdmin.register User do

  menu :parent => "Site Admin"

  permit_params :first_name, :last_name, :email, :password, :password_confirmation, role_ids: [], show_memberships_attributes: [:id, :show_id, :user_id, :_destroy], team_memberships_attributes: [:id, :team_id, :user_id, :_destroy]

  scope :to_approve

  controller do

    # Override the update action to allow saving with an empty password field
    def update
      model = :user
      if params[model][:password].blank?
        %w(password password_confirmation).each { |p| params[model].delete(p) }
      end

      super
    end

  end


  member_action :approve, :method => :post do
    user = User.find(params[:id])
    user.approved = true
    user.save
    redirect_to admin_users_path

    # Notify user of success or failure
    if user.errors.empty?
      flash[:notice] = "User approved"
    else
      user.errors.each do |attribute, message|
        flash[:errors] = "#{attribute}: #{message}"
      end
    end

  end


  member_action :cancel_approval, :method => :post do
    user = User.find(params[:id])
    user.approved = false
    user.save
    redirect_to admin_users_path

    # Notify user of success or failure
    if user.errors.empty?
      flash[:notice] = "User approval canceled"
    else
      user.errors.each do |attribute, message|
        flash[:errors] = "#{attribute}: #{message}"
      end
    end

  end


  index do
    column :first_name
    column :last_name
    column :email
    column :roles do |user|
      user.roles.each do |role|
        li role.name
      end
      ''
    end

    column :shows do |user|
      user.shows.each do |show|
        li show.title
      end
      ''
    end

    column :teams do |user|
      user.team_memberships.each do |tm|
        if tm.is_manager
          li tm.team.name + '(Manager)'
        else
          li tm.team.name
        end
      end
      ''
    end

    column(:email_confirmed) do |user|
      user.confirmed? ? status_tag( "yes", :ok ) : status_tag( "no" )
    end
    column :approved

    column '' do |user|

      if user.approved?
        link_to 'Cancel approval', cancel_approval_admin_user_path(user), method: :post
      else
        link_to 'Approve', approve_admin_user_path(user), method: :post
      end
    end

    actions

  end

  filter :first_name
  filter :last_name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :roles, collection: Role.existing_roles
  filter :approved
  filter :confirmed_at, as: :string

  show do |user|
    panel 'User details' do
      attributes_table_for user do
        row :email
        row :first_name
        row :last_name
        row :roles do
          user.roles.each do |role|
            li role.name
          end
          ''
        end

        row :shows do |user|
          user.shows.each do |show|
            li show.title
          end
          ''
        end

        row :teams do
          user.team_memberships.each do |tm|
            if tm.is_manager
              li tm.team.name + '(Manager)'
            else
              li tm.team.name
            end
          end
          ''
        end

        row :approved
        row :approval do |user|

          if user.approved?
            link_to 'Cancel approval', cancel_approval_admin_user_path(user), method: :post
          else
            link_to 'Approve', approve_admin_user_path(user), method: :post
          end
        end
        row :unconfirmed_email
        row :confirmed_at
        row :confirmation_token
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :created_at
        row :updated_at
        row :confirmation_sent_at
        row :failed_attempts
        row :unlock_token
        row :locked_at
        row :encrypted_password
        row :reset_password_token
        row :reset_password_sent_at
        row :remember_created_at
      end
    end

  end



  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password, placeholder: 'Leave blank to remain unchanged'
      f.input :password_confirmation
      # Common users should not be able to edit their profile through Active Admin!
      f.input :roles, as: :check_boxes, collection: Role.existing_roles
    end

    f.inputs name: 'Show assignments' do
      f.has_many :show_memberships, :allow_destroy => true do |tmf|
        tmf.input :show, collection: Show.by_title
      end
    end

    f.inputs name: 'Team assignments' do
      f.has_many :team_memberships, :allow_destroy => true do |tmf|
        tmf.input :team, collection: Team.all
        tmf.input :is_manager
      end
    end

    f.actions
  end

end
