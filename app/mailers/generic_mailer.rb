class GenericMailer < ApplicationMailer

  def new_user_notification(user)
    @user = user
    mail(to: ENV['WEBMASTER_EMAIL'], subject: 'New user pending')
  end

  def account_approval(user)
    @user = user
    mail(to: user.email, subject: 'Your account has been approved')
  end

  def new_issue(issue)
    @issue = issue
    mail(to: ENV['WEBMASTER_EMAIL'], subject: 'New issue submitted')
  end

end
