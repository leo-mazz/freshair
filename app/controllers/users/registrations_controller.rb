class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      # https://github.com/RolifyCommunity/rolify/issues/246
      params['user']['_roles'] ||= []
      params['user']['_roles'].each do |role|
        resource.add_role role
      end
      @show = params['user']['_show']
      @is_manager = params['user']['team_manager?'] || false
      if @show != 'nil'
        @show_membership = ShowMembership.create(user: resource, show: Show.find(@show), is_manager: @is_manager)
      end

      @team = params['user']['_team']
      if @team != 'nil'
        @team_membership = TeamMembership.create(user:resource, team:Team.find(@team))
      end

      # Notify webmaster there's a user to approve
      if resource.errors.empty?
        AdminMailer.new_user_notification(resource).deliver_later
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  # If you have extra params to permit, append them to the sanitizer.

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:first_name, :last_name, :email, :password, :password_confirmation]
    )
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys:
      ([:first_name, :last_name, :email, :password, :password_confirmation])
    )
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
