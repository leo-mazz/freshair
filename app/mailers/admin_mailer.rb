class AdminMailer < ApplicationMailer

  def new_user_notification(user)
    @user = user
    # TODO: remember to change this in production (make it an ENV variable)
    mail(to: 'leo.mazzone15@gmail.com', subject: 'New user pending')
  end

end
