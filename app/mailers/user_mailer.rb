class UserMailer < ApplicationMailer
  default from: 'notifications@villagebicycle.com'

  def welcome_email(user)
    @user = user
    @url = "localhost:3000/users/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: 'Village Bicycle Account Activiation')
  end
end
