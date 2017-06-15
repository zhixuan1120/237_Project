class MicropostMailer < ActionMailer::Base
  default from: "admin@yipiejihe.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.micropost_mailer.find_match.subject
  #
  def find_match(user1, user2, post)
    @user1 = user1
    @user2 = user2
    @post = post
    mail to: @user1.email, subject: "Someone also wants to tell you"
  end
end
