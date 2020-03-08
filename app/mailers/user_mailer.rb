class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.thanks.subject
  #
  def thanks(user)
    @user = user
    # binding.pry
    mail to: @user.email, subject: 'Welcome to Our Application!'
  end

end
