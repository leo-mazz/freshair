class AdminMailer < ApplicationMailer

  def new_user_notification(user)
    @user = user
    mail(to: ENV['WEBMASTER_EMAIL'], subject: 'New user pending')
  end

end
